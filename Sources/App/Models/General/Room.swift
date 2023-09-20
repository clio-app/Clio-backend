//
//  File.swift
//  
//
//  Created by Thiago Henrique on 18/09/23.
//

import Foundation
import FluentKit
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
    var createdBy: User
    @Field(key: "participants")
    var participants: [RoomUser]
    @Field(key: "gameStarted")
    var gameStarted: Bool
    @OptionalField(key: "password")
    var password: String?
}

