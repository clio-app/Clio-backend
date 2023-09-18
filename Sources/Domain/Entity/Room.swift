//
//  File.swift
//  
//
//  Created by Thiago Henrique on 18/09/23.
//

import Foundation

struct Room {
    let id: UUID
    let name: String
    let theme: Theme
    let createdBy: User
    let participants: [RoomUser]
    let gameStarted: Bool = false
    let password: String? = nil
}
