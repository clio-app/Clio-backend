//
//  File.swift
//  
//
//  Created by Thiago Henrique on 27/09/23.
//

import Foundation
import Vapor
import Domain

class GameSystemController: RouteCollection {
    private(set) var connections: [SocketConnection] = [SocketConnection]()
    let registerUserInRoomUseCase: RegisterUserInRoomUseCase
    
    init(registerUserInRoomUseCase: RegisterUserInRoomUseCase) {
        self.registerUserInRoomUseCase = registerUserInRoomUseCase
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
                            print(error.localizedDescription)
                        }
                    case .server(_):
                        break
                }
            }
        }
    }
    
    func sendMessageToAllConnections(_ message: TransferMessage) {
        let messageData = message.encodeToTransfer()
        for connection in connections {
            connection.socket.send(
                raw: messageData,
                opcode: .binary
            )
        }
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
                connections.append(SocketConnection(id: dto.user.id, socket: socket))
                sendMessageToAllConnections(
                    TransferMessage(
                        state: .server(.connection(.playerConnected)),
                        data: response.encodeToTransfer()
                    )
                )
            case .masterActing:
                break
            case .masterSharing:
                break
            case .userDidAct:
                break
            case .startVoting:
                break
            case .userDidVote:
                break
            case .roundEnd:
                break
        }
    }
}
