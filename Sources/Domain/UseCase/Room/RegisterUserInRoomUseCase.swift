//
//  File.swift
//  
//
//  Created by Thiago Henrique on 20/09/23.
//

import Foundation

public class RegisterUserInRoomUseCase: AnyUseCase {
    private let repository: RoomRepository
    
    public init(repository: RoomRepository) {
        self.repository = repository
    }
    
    public func execute(request: RegisterUserRequest) async throws -> Void {
        try await repository.registerUserInRoom(request)
    }
}
