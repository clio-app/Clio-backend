//
//  File.swift
//  
//
//  Created by Thiago Henrique on 19/09/23.
//

import Foundation

public protocol RoomRepository {
    func createRoom(_ room: CreateRoomRequest) async throws -> RoomCode
    func registerUserInRoom(_ request: RegisterUserRequest) async throws 
}
