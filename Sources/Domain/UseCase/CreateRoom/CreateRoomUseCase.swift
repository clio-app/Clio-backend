//
//  File.swift
//  
//
//  Created by Thiago Henrique on 19/09/23.
//

import Foundation

public struct CreateRoomUseCase: AnyUseCase {
    private let repository: RoomRepository
    
    public init(repository: RoomRepository) {
        self.repository = repository
    }
    
    public func execute(request: Room) async throws -> Void {
        
    }
}
