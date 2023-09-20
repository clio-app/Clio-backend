//
//  File.swift
//  
//
//  Created by Thiago Henrique on 18/09/23.
//

import Foundation
import FluentKit
import Domain
import Vapor

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
    
    convenience init(from domain: Domain.Room) {
        self.init()
        
        self.id = domain.id
        self.name = domain.name
        self.theme = Theme(from: domain.theme)
        self.createdBy = domain.createdBy != nil ? User(from: domain.createdBy!) : nil
        self.master = domain.master != nil ? RoomUser(from: domain.master!) : nil
        self.participants = domain.participants.compactMap( { RoomUser(from: $0)} )
        self.gameStarted = domain.gameStarted
        self.password = domain.password
    }
}

