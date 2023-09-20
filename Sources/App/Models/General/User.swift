//
//  File.swift
//  
//
//  Created by Thiago Henrique on 18/09/23.
//

import Foundation
import FluentKit
import Domain

final class User: Model {
    static var schema: String = "users"
    
    @ID(key: .id)
    var id: UUID?
    @Field(key: "name")
    var name: String
    
    convenience init(from domain: Domain.User) {
        self.init()
        self.id = domain.id
        self.name = domain.name
    }
}
