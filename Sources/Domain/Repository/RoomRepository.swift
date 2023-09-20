//
//  File.swift
//  
//
//  Created by Thiago Henrique on 19/09/23.
//

import Foundation

public protocol RoomRepository {
    func createRoom(_ room: Room) async throws -> RoomCode
}
