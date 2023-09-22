//
//  File.swift
//  
//
//  Created by Thiago Henrique on 22/09/23.
//

import Foundation
import Vapor
import Domain

final class UserController: RouteCollection {
    let createUserUseCase: CreateUserUseCase
    
    init(createUserUseCase: CreateUserUseCase) {
        self.createUserUseCase = createUserUseCase
    }
    
    func boot(routes: RoutesBuilder) throws {
        let group = routes.grouped("user")
        group.post("create", use: create)
    }
    
    func create(_ request: Request) async throws -> App.User {
        try CreateUserRequestValidator.validate(content: request)
        let requestData = try request.content.decode(CreateUserRequest.self)
        let responseData = try await createUserUseCase.execute(request: requestData)
        
        return App.User(from: responseData)
    }
}
