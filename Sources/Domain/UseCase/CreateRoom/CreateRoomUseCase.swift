//
//  File.swift
//  
//
//  Created by Thiago Henrique on 19/09/23.
//

import Foundation

public class CreateRoomUseCase: AnyUseCase {
    private let repository: RoomRepository
    
    public init(repository: RoomRepository) {
        self.repository = repository
    }
    
    public func execute(request: Room) async throws -> RoomCode {
        return try await repository.createRoom(request)
    }
}
