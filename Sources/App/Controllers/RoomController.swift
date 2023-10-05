//
//  File.swift
//  
//
//  Created by Thiago Henrique on 19/09/23.
//

import Foundation
import Vapor
import Domain
import ClioEntities

class RoomController: RouteCollection {
    private var createRoomUseCase: CreateRoomUseCase
    private var registerUserInRoomUseCase: RegisterUserInRoomUseCase
    private var getAllRoomsUseCase: GetAllRoomsUseCase
    private var findRoomUseCase: FindRoomUseCase
    
    public init(
        createRoomUseCase: CreateRoomUseCase,
        registerUserInRoomUseCase: RegisterUserInRoomUseCase,
        getAllRoomsUseCase: GetAllRoomsUseCase,
        findRoomUseCase: FindRoomUseCase
    ) {
        self.createRoomUseCase = createRoomUseCase
        self.registerUserInRoomUseCase = registerUserInRoomUseCase
        self.getAllRoomsUseCase = getAllRoomsUseCase
        self.findRoomUseCase = findRoomUseCase
    }
    
    func boot(routes: RoutesBuilder) throws {
        let group = routes.grouped("room")
        group.group(":id") { $0.get(use: find) }
        group.get(use: index)
        group.post("create", use: create)
    }
    
    func index(_ request: Request) async throws -> [App.Room] {
        let rooms: [ClioEntities.Room] = try await getAllRoomsUseCase.execute(request: request)
        return rooms.compactMap( { Room(from: $0) } )
    }
    
    func find(_ request: Request) async throws -> App.Room {
        guard let roomId = request.parameters.get("id") else { throw Abort(.badRequest) }
        do {
            let responseData: ClioEntities.Room = try await findRoomUseCase.execute(request: roomId)
            return App.Room(from: responseData)
        } catch {
            throw Abort(.custom(code: 400, reasonPhrase: error.localizedDescription))
        }
    }
    
    func create(_ request: Request) async throws -> CreateRoomResponse {
        try CreateRoomRequestValidator.validate(content: request)
        let requestData = try request.content.decode(CreateRoomRequest.self)
        let responseData = try await createRoomUseCase.execute(request: requestData)
        
        return CreateRoomResponse(id: responseData.code)
    }
}
