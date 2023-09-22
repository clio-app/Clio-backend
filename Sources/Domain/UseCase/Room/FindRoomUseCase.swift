//
//  File.swift
//  
//
//  Created by Thiago Henrique on 20/09/23.
//

import Foundation

public final class FindRoomUseCase: AnyUseCase {
    private let repository: RoomRepository
    
    public init(repository: RoomRepository) {
        self.repository = repository
    }
    
    public func execute(request: String) async throws -> Room {
        return try await repository.findRoomById(request)
    }
}
