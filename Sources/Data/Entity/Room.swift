//
//  File.swift
//  
//
//  Created by Thiago Henrique on 18/09/23.
//

import Foundation
import FluentKit

final class Room: Model {
    static var schema: String = "rooms"

    @ID(key: .id)
    var id: UUID?
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
