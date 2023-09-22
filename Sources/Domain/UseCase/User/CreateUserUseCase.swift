//
//  File.swift
//  
//
//  Created by Thiago Henrique on 22/09/23.
//

import Foundation

public final class CreateUserUseCase: AnyUseCase {
    private let repository: UserRepository
    
    public init(repository: UserRepository) { self.repository = repository }
    
    public func execute(request: CreateUserRequest) async throws -> User {
        return try await repository.createUser(name: request.name, picture: request.picture)
    }
}
