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

final class User: Model, Content {
    static var schema: String = "users"
    
    @ID(key: .id)
    var id: UUID?
    @Field(key: "name")
    var name: String
    @Field(key: "picture")
    var picture: String
    
    convenience init(from entity: ClioEntities.User) {
        self.init()
        self.id = entity.id
        self.name = entity.name
        self.picture = entity.picture
    }
}
