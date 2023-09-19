//
//  File.swift
//  
//
//  Created by Thiago Henrique on 19/09/23.
//

import Foundation
import Vapor
import Domain

class RoomController: RouteCollection {
    private var createRoomUseCase: CreateRoomUseCase
    
    public init(createRoomUseCase: CreateRoomUseCase) {
        self.createRoomUseCase = createRoomUseCase
    }
    
    func boot(routes: RoutesBuilder) throws {
        let group = routes.grouped("room")
        group.post("create", use: createRoom)
    }
    
    func createRoom(_ request: Request) async throws -> BaseResponse<Empty> {
        try RoomRequest.validate(content: request)
        let requestData = try request.content.decode(Room.self)
        let responseData = try await createRoomUseCase.execute(request: requestData)

        return BaseResponse(status: 200, message: "", data: nil)
    }
}
