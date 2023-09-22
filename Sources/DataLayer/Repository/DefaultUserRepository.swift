//
//  File.swift
//  
//
//  Created by Thiago Henrique on 22/09/23.
//

import Foundation
import Domain

public final class DefaultUserRepository: UserRepository {
    private var users: [User] = []
    
    public init() {}
    
    public func createUser(name: String, picture: String) async throws -> Domain.User {
        let newUser = Domain.User(id: UUID(), name: name, picture: picture)
        users.append(newUser)
        return newUser
    }
}
