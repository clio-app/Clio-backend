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
        
        socket.onText { socket, value in
            print(value)
        }
    }
}
