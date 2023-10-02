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
    
    func boot(routes: RoutesBuilder) throws {
        let group = routes.grouped("game")
        group.webSocket(":roomID", onUpgrade: onSocketUpgrade)
    }
    
    func onSocketUpgrade(_ request: Request, _ socket: WebSocket) {
        guard let roomId = request.parameters.get("roomID") else { return }
        
        socket.onText { [weak self] socket, value in
            guard let strongSelf = self else { return }
            if let request = try? JSONDecoder().decode(
                TransferMessage.self,
                from: value.data(using: .utf8)!
            ) {
                switch request.state {
                    case .client(let clientMessages):
                        strongSelf.handleSocketClientRequest(
                            roomId,
                            socket,
                            message: request,
                            state: clientMessages
                        )
                    case .server(_):
                        break
                }
            }
        }
    }
    
    func handleSocketClientRequest(
        _ roomId: String,
        _ socket: WebSocket,
        message: TransferMessage,
        state: MessageState.ClientMessages
    ) {
        switch state {
            case .gameFlow(let gameFlowMessage):
                handleSocketGameflowRequest(
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
    ) {
        switch state {
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
