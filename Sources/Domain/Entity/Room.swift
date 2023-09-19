//
//  File.swift
//  
//
//  Created by Thiago Henrique on 18/09/23.
//

import Foundation

public struct Room: Codable {
    public let id: UUID?
    public let name: String
    public let theme: Theme
    public let createdBy: User
    public let participants: [RoomUser]
    public let gameStarted: Bool
    public let password: String?
    
    public init(id: UUID? = nil, name: String, theme: Theme, createdBy: User, participants: [RoomUser], gameStarted: Bool, password: String?) {
        self.id = id
        self.name = name
        self.theme = theme
        self.createdBy = createdBy
        self.participants = participants
        self.gameStarted = gameStarted
        self.password = password
    }
}
