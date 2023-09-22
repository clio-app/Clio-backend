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

final class User: Model, Content {
    static var schema: String = "users"
    
    @ID(key: .id)
    var id: UUID?
    @Field(key: "name")
    var name: String
    @Field(key: "picture")
    var picture: String
    
    convenience init(from domain: Domain.User) {
        self.init()
        self.id = domain.id
        self.name = domain.name
        self.picture = domain.picture
    }
}
