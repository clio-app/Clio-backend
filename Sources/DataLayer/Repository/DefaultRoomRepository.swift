//
//  File.swift
//  
//
//  Created by Thiago Henrique on 19/09/23.
//

import Foundation
import Domain

public class DefaultRoomRepository: RoomRepository {
    private var sessions: [Domain.Room] = []
    
    public init() {}
    
    public func createRoom(_ room: Domain.Room) async throws -> Domain.RoomCode {
        var inputedRoom = room
        var sessionCode = generateCode()
        
        while sessions.contains(where: { $0.id == sessionCode }) {
            sessionCode = generateCode()
        }
        
        inputedRoom.id = sessionCode
        sessions.append(inputedRoom)
        
        return Domain.RoomCode(code: sessionCode)
    }
    
    private func generateCode() -> String {
        return String(UUID().uuidString.prefix(6)).trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
