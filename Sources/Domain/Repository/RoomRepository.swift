//
//  File.swift
//  
//
//  Created by Thiago Henrique on 19/09/23.
//

import Foundation
import ClioEntities

public protocol RoomRepository {
    func createRoom(_ room: CreateRoomRequest) -> RoomCode
    func registerUserInRoom(_ request: RegisterUserRequest) throws -> UpdatePlayersRoomDTO
    func getAllRooms() -> [Room]
    func findRoomById(_ id: String) throws -> Room
}
