//
//  File.swift
//  
//
//  Created by Thiago Henrique on 20/09/23.
//

import Foundation
import Domain

struct RegisterUserInRoomRequest: Codable {
    let roomCode: String
    let user: Domain.User
}
