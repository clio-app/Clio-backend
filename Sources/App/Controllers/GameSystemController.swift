//
//  File.swift
//  
//
//  Created by Thiago Henrique on 27/09/23.
//

import Foundation
import Vapor
import Domain
import ClioEntities

class GameSystemController: RouteCollection {
    private(set) var connections: [SocketConnection] = [SocketConnection]()
    let registerUserInRoomUseCase: RegisterUserInRoomUseCase
    let startGameUseCase: StartGameUseCase
    let sendMasterArtefactsUseCase: SendMasterArtefactsUseCase
    let sendUserResponseUseCase: SendUserResponseUseCase
    let startVotingUseCase: StartVotingUseCase
    let computeVotingUseCase: ComputeVotingUseCase
    
    init(
        registerUserInRoomUseCase: RegisterUserInRoomUseCase,
        startGameUseCase: StartGameUseCase,
        sendMasterArtefactsUseCase: SendMasterArtefactsUseCase,
        sendUserResponseUseCase: SendUserResponseUseCase,
        startVotingUseCase: StartVotingUseCase,
        computeVotingUseCase: ComputeVotingUseCase
    ) {
        self.registerUserInRoomUseCase = registerUserInRoomUseCase
        self.startGameUseCase = startGameUseCase
        self.sendMasterArtefactsUseCase = sendMasterArtefactsUseCase
        self.sendUserResponseUseCase = sendUserResponseUseCase
        self.startVotingUseCase = startVotingUseCase
        self.computeVotingUseCase = computeVotingUseCase
    }
    
    func boot(routes: RoutesBuilder) throws {
        let group = routes.grouped("game")
        group.webSocket(":roomID", onUpgrade: onSocketUpgrade)
    }
    
    func onSocketUpgrade(_ request: Request, _ socket: WebSocket) {
        guard let roomId = request.parameters.get("roomID") else { return }
        
        socket.onBinary { [weak self] socket, value in
            guard let strongSelf = self else { return }
        
            if let request = try? JSONDecoder().decode(
                TransferMessage.self,
                from: value
            ) {
                switch request.state {
                    case .client(let clientMessages):
                        do {
                            try await strongSelf.handleSocketClientRequest(
                                 roomId,
                                 socket,
                                 message: request,
                                 state: clientMessages
                             )
                        } catch {
                            let message = TransferMessage(
                                state: .server(.error),
                                data: SocketError.cantHandleClientMessage(
                                    error.localizedDescription
                                )
                                .errorDescription?.data(using: .utf8) ?? Data()
                            )
                            
                            try? await socket.send(
                                raw: message.encodeToTransfer(),
                                opcode: .binary
                            )
                        }
                    case .server(_):
                        break
                }
            } else {
                let message = TransferMessage(
                    state: .server(.error),
                    data: SocketError.unableToDecodeMessage.errorDescription?.data(using: .utf8) ?? Data()
                )
                
                try? await socket.send(
                    raw: message.encodeToTransfer(),
                    opcode: .binary
                )
            }
        }
    }
    
    func sendMessageToAllConnections(_ message: TransferMessage, in room: String) {
        let messageData = message.encodeToTransfer()
        let connectionsInRoom = connections.filter( { $0.roomId == room })
        connectionsInRoom.forEach { $0.socket.send(raw: messageData, opcode: .binary) }
    }
    
    func handleSocketClientRequest(
        _ roomId: String,
        _ socket: WebSocket,
        message: TransferMessage,
        state: MessageState.ClientMessages
    ) async throws {
        switch state {
            case .gameFlow(let gameFlowMessage):
                try await handleSocketGameflowRequest(
                    roomId,
                    socket,
                    message: message,
                    state: gameFlowMessage
                )
        }
    }
    
    func handleSocketGameflowRequest(
        _ roomId: String,
        _ socket: WebSocket,
        message: TransferMessage,
        state: MessageState.ClientMessages.ClientGameFlow
    ) async throws {
        switch state {
            case .registerUser:
                let dto = RegisterUserinRoomDTO.decodeFromMessage(message.data)
                let response: UpdatePlayersRoomDTO = try await registerUserInRoomUseCase.execute(
                    request: RegisterUserRequest(
                        roomCode: roomId,
                        user: dto.user
                    )
                )
                connections.append(
                    SocketConnection(
                        roomId: roomId,
                        userId: dto.user.id,
                        socket: socket
                    )
                )
                sendMessageToAllConnections(
                    TransferMessage(
                        state: .server(.connection(.playerConnected)),
                        data: response.encodeToTransfer()
                    ),
                    in: roomId
                )
            case .gameStarted:
                let dto = BooleanMessageDTO.decodeFromMessage(message.data)
                if !dto.value { return }
            
                let response: MasterActingDTO = try await startGameUseCase.execute(
                    request: roomId
                )
                sendMessageToAllConnections(
                    TransferMessage(
                        state: .server(.gameFlow(.masterActing)),
                        data: response.encodeToTransfer()
                    ),
                    in: roomId
                )
            case .masterActed:
                let dto = MasterActedDTO.decodeFromMessage(message.data)
                let response: MasterSharingDTO = sendMasterArtefactsUseCase.execute(request: dto)
                sendMessageToAllConnections(
                    TransferMessage(
                        state: .server(.gameFlow(.masterSharing)),
                        data: response.encodeToTransfer()
                    ),
                    in: roomId
                )
            case .userActed:
                let dto = UserActedDTO.decodeFromMessage(message.data)
                let response: UserDidActDTO = sendUserResponseUseCase.execute(request: dto)
                sendMessageToAllConnections(
                    TransferMessage(
                        state: .server(.gameFlow(.userDidAct)),
                        data: response.encodeToTransfer()
                    ),
                    in: roomId
                )
                if let votingDTO = startVotingUseCase.execute(request: response) {
                    sendMessageToAllConnections(
                        TransferMessage(
                            state: .server(.gameFlow(.startVoting)),
                            data: votingDTO.encodeToTransfer()
                        ),
                        in: roomId
                    )
                }
            case .userVoted:
                let dto = UserVotedDTO.decodeFromMessage(message.data)
                let response: UserDidVoteDTO = computeVotingUseCase.execute(request: dto)
                sendMessageToAllConnections(
                    TransferMessage(
                        state: .server(.gameFlow(.userDidVote)),
                        data: response.encodeToTransfer()
                    ),
                    in: roomId
                )
            // verify round end
            case .playAgain:
                break
        }
    }
}
