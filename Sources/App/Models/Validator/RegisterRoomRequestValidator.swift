//
//  File.swift
//  
//
//  Created by Thiago Henrique on 20/09/23.
//

import Foundation
import Vapor

struct RegisterRoomRequestValidator: Content, Validatable {
    public let roomCode: String
    public let user: User
    
    static func validations(_ validations: inout Vapor.Validations) {
        validations.add(
            "roomCode",
            as: String.self,
            is: !.empty,
            customFailureDescription: "O campo código está vazio"
        )
        
        validations.add(
            "user",
            customFailureDescription: "Usuário inválido"
        ) { userValidator in
            userValidator.add("id", as: String.self, is: !.empty)
            userValidator.add("name", as: String.self, is: !.empty)
        }
    }
}
