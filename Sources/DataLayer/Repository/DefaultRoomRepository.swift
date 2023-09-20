//
//  File.swift
//  
//
//  Created by Thiago Henrique on 19/09/23.
//

import Foundation
import Domain

public class DefaultRoomRepository: RoomRepository {
    private var sessions: [Room] = []
    
    public init() {}
    
    public func createRoom(_ room: Room) async throws -> RoomCode {
        var inputedRoom = room
        var sessionCode = generateCode()
        
        while sessions.contains(where: { $0.id == sessionCode }) {
            sessionCode = generateCode()
        }
        
        inputedRoom.id = sessionCode
        sessions.append(inputedRoom)
        
        return RoomCode(code: sessionCode)
    }
    
    public func registerUserInRoom(_ request: RegisterUser) async throws {
        if let sessionIndex = sessions.firstIndex(where: { $0.id == request.roomCode }) {
            sessions[sessionIndex].participants.append(
                RoomUser(
                    rankingPosition: sessions[sessionIndex].participants.count + 1,
                    points: 0,
                    user: request.user
                )
            )
        } else {
            throw RoomRepositoryError.cantFindRoom
        }
    }

    private func generateCode() -> String {
        return String(UUID().uuidString.prefix(6)).trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

enum RoomRepositoryError: LocalizedError {
    case cantFindRoom
    
    var errorDescription: String? {
        switch self {
            case .cantFindRoom:
                return "Não foi possível encontrar uma sala com esse código"
        }
    }
}
