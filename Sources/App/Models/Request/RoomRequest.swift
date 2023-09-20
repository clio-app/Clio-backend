//
//  File.swift
//  
//
//  Created by Thiago Henrique on 19/09/23.
//

import Foundation
import Vapor
import Domain

struct RoomRequest: Content, Validatable {
    public let name: String
    public let theme: Domain.Theme
    public let createdBy: Domain.User
    public let participants: [Domain.RoomUser]
    public let gameStarted: Bool
    public let password: String?

    static func validations(_ validations: inout Validations) {
        validations.add(
            "name",
            as: String.self,
            is: !.empty,
            customFailureDescription: "Provided name is empty!"
        )
        
        validations.add("theme", customFailureDescription: "Provided theme is empty!") { themeValidator in
            themeValidator.add(
                "title",
                as: String.self,
                is: !.empty
            )
        }
    }
}
