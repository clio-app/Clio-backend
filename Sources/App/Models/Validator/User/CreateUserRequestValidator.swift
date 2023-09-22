//
//  File.swift
//  
//
//  Created by Thiago Henrique on 22/09/23.
//

import Foundation
import Vapor

struct CreateUserRequestValidator: Content, Validatable {
    public let name: String
    public let picture: String
    
    static func validations(_ validations: inout Vapor.Validations) {
        validations.add("name", as: String.self, is: !.empty)
        validations.add("picture", as: String.self, is: !.empty)
    }
}

