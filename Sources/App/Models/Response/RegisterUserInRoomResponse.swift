//
//  File.swift
//  
//
//  Created by Thiago Henrique on 20/09/23.
//

import Foundation
import Vapor

enum MessageType: String, Codable {
    case success = "Usuário registrado com sucesso"
}

public final class RegisterUserInRoomResponse: Content {
    let message: MessageType
    
    init(message: MessageType) {
        self.message = message
    }
}
