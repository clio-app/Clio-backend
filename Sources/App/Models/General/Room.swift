//
//  File.swift
//  
//
//  Created by Thiago Henrique on 18/09/23.
//

import Foundation
import FluentKit
import Vapor
import ClioEntities

final class Room: Model, Content {
    static var schema: String = "rooms"
    
    @ID(custom: "id")
    var id: String?
    @Field(key: "name")
    var name: String
    @Field(key: "theme")
    var theme: Theme
    @Field(key: "createBy")
    var createdBy: User?
    @Field(key: "master")
    var master: RoomUser?
    @Field(key: "participants")
    var participants: [RoomUser]
    @Field(key: "gameStarted")
    var gameStarted: Bool
    @OptionalField(key: "password")
    var password: String?
    
    convenience init(from entity: ClioEntities.Room) {
        self.init()
        
        self.id = entity.id
        self.name = entity.name
        self.theme = Theme(from: entity.theme)
        self.createdBy = entity.createdBy != nil ? User(from: entity.createdBy!) : nil
        self.master = entity.master != nil ? App.RoomUser(from: entity.master!) : nil
        self.participants = entity.participants.compactMap( { App.RoomUser(from: $0)} )
        self.gameStarted = entity.gameStarted
        self.password = entity.password
    }
}

