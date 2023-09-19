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
    
    public init(createRoomUseCase: CreateRoomUseCase) {
        self.createRoomUseCase = createRoomUseCase
    }
    
    func boot(routes: RoutesBuilder) throws {
        let group = routes.grouped("room")
        group.post("create", use: create)
    }
    
    func create(_ request: Request) async throws -> BaseResponse<DataLayer.RoomCode> {
        try RoomRequest.validate(content: request)
        let requestData = try request.content.decode(Room.self)
        let responseData = try await createRoomUseCase.execute(request: requestData)
        
        return BaseResponse(
            status: 200,
            message: "Success",
            data: DataLayer.RoomCode(id: responseData.code)
        )
    }
}
