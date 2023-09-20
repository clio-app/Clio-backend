//
//  File.swift
//  
//
//  Created by Thiago Henrique on 19/09/23.
//

import Foundation
import Vapor
import Domain
import DataLayer

class RoomController: RouteCollection {
    private var createRoomUseCase: CreateRoomUseCase
    private var registerUserInRoomUseCase: RegisterUserInRoomUseCase
    
    public init(
        createRoomUseCase: CreateRoomUseCase,
        registerUserInRoomUseCase: RegisterUserInRoomUseCase
    ) {
        self.createRoomUseCase = createRoomUseCase
        self.registerUserInRoomUseCase = registerUserInRoomUseCase
    }
    
    func boot(routes: RoutesBuilder) throws {
        let group = routes.grouped("room")
        group.post("create", use: create)
        group.post("register", use: register)
    }
    
    func create(_ request: Request) async throws -> CreateRoomResponse {
        try CreateRoomRequestValidator.validate(content: request)
        let requestData = try request.content.decode(CreateRoomRequest.self)
        let responseData = try await createRoomUseCase.execute(request: requestData)
        
        return CreateRoomResponse(id: responseData.code)
    }
    
    func register(_ request: Request) async throws -> RegisterUserInRoomResponse {
        try RegisterRoomRequestValidator.validate(content: request)
        let requestData = try request.content.decode(RegisterUserRequest.self)
        
        do {
            try await registerUserInRoomUseCase.execute(request: requestData)
        } catch {
            throw Abort(.custom(code: 400, reasonPhrase: error.localizedDescription))
        }
        
        return RegisterUserInRoomResponse(message: .success)
    }
}
