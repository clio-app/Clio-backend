//
//  File.swift
//  
//
//  Created by Thiago Henrique on 19/09/23.
//

import Foundation
import Domain
import ClioEntities

public class DefaultRoomRepository: RoomRepository {
    private var sessions: [Room] = []
    
    public init() {}
    
    public func createRoom(_ room: CreateRoomRequest) async throws -> RoomCode {
        var sessionCode = generateCode()
        
        while sessions.contains(where: { $0.id == sessionCode }) {
            sessionCode = generateCode()
        }
        
        sessions.append(
            Room(
                id: sessionCode,
                name: room.name,
                theme: room.theme,
                participants: [],
                gameStarted: false
            )
        )
        
        return RoomCode(code: sessionCode)
    }
    
    public func registerUserInRoom(
        _ request: RegisterUserRequest
    ) async throws -> UpdatePlayersRoomDTO {
        if let sessionIndex = sessions.firstIndex(where: { $0.id == request.roomCode }) {
            if sessions[sessionIndex].createdBy == nil {
                sessions[sessionIndex].createdBy = request.user
                sessions[sessionIndex].master = RoomUser(
                    rankingPosition: 0,
                    points: 0,
                    user: request.user
                )
            } else {
                sessions[sessionIndex].participants.append(
                    RoomUser(
                        rankingPosition: sessions[sessionIndex].participants.count + 1,
                        points: 0,
                        user: request.user
                    )
                )
            }
            
            return UpdatePlayersRoomDTO(
                master: sessions[sessionIndex].master!,
                users: sessions[sessionIndex].participants
            )
        } else {
            throw RoomRepositoryError.cantFindRoom
        }
    }

    public func getAllRooms() async throws -> [Room] {
        return sessions
    }
    
    public func findRoomById(_ id: String) async throws -> Room {
        if let room = sessions.first(where: { $0.id == id } ) { return room }
        throw RoomRepositoryError.cantFindRoom
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
