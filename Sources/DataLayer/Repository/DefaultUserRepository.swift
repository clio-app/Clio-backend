//
//  File.swift
//  
//
//  Created by Thiago Henrique on 22/09/23.
//

import Foundation
import Domain
import ClioEntities

public final class DefaultUserRepository: UserRepository {
    private var users: [User] = []
    
    public init() {}
    
    public func createUser(name: String, picture: String) async throws -> User {
        let newUser = User(id: UUID(), name: name, picture: picture)
        users.append(newUser)
        return newUser
    }
}
