//
//  File.swift
//  
//
//  Created by Thiago Henrique on 19/09/23.
//

import Foundation
import Domain

public class DefaultRoomRepository: RoomRepository {
    private var sessions: Set<String> = Set()
    
    public init() {}
    
    public func createRoom(_ room: Domain.Room) async throws -> Domain.RoomCode {
        var sessionCode = generateCode()
        var inserted = sessions.insert(sessionCode).inserted
        
        while !inserted {
            sessionCode = generateCode()
            inserted = sessions.insert(sessionCode).inserted
        }
        
        return Domain.RoomCode(code: sessionCode)
    }
    
    private func generateCode() -> String {
        return String(UUID().uuidString.prefix(6)).trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
