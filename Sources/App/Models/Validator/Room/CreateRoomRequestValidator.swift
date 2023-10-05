//
//  File.swift
//  
//
//  Created by Thiago Henrique on 19/09/23.
//

import Foundation
import Vapor
import Domain
import ClioEntities

struct CreateRoomRequestValidator: Content, Validatable {
    public let name: String
    public let theme: Theme
    public let createdBy: User
    public let participants: [RoomUser]
    public let gameStarted: Bool
    public let password: String?

    static func validations(_ validations: inout Validations) {
        validations.add(
            "name",
            as: String.self,
            is: !.empty,
            customFailureDescription: "O campo nome está vazio!"
        )
        
        validations.add("theme", customFailureDescription: "O campo tema está vazio") { themeValidator in
            themeValidator.add(
                "title",
                as: String.self,
                is: !.empty
            )
        }
    }
}
