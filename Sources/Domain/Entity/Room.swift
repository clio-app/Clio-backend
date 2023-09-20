//
//  File.swift
//  
//
//  Created by Thiago Henrique on 18/09/23.
//

import Foundation

public struct Room: Codable {
    public var id: String?
    public let name: String
    public let theme: Theme
    public var createdBy: User?
    public var master: RoomUser?
    public var participants: [RoomUser]
    public let gameStarted: Bool
    public let password: String?
    
    public init(id: String? = nil, name: String, theme: Theme, createdBy: User? = nil, master: RoomUser? = nil, participants: [RoomUser], gameStarted: Bool, password: String? = nil) {
        self.id = id
        self.name = name
        self.theme = theme
        self.createdBy = createdBy
        self.master = master
        self.participants = participants
        self.gameStarted = gameStarted
        self.password = password
    }
}
