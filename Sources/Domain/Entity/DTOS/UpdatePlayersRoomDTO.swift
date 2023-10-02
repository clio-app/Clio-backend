//
//  File.swift
//  
//
//  Created by Thiago Henrique on 02/10/23.
//

import Foundation

public struct UpdatePlayersRoomDTO: DTO {
    public let master: RoomUser
    public let users: [RoomUser]
    
    public init(master: RoomUser, users: [RoomUser]) {
        self.master = master
        self.users = users
    }
}
