//
//  File.swift
//  
//
//  Created by Thiago Henrique on 20/09/23.
//

import Foundation

public struct RegisterUserRequest: Codable {
    public let roomCode: String
    public let user: User
}
