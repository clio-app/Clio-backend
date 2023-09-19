//
//  File.swift
//  
//
//  Created by Thiago Henrique on 19/09/23.
//

import Foundation
import Domain

public class DefaultRoomRepository: RoomRepository {    
    public init() {}
    
    public func createRoom(_ room: Domain.Room) async throws -> Domain.RoomCode {
        return Domain.RoomCode(code: UUID())
    }
}
