//
//  File.swift
//  
//
//  Created by Thiago Henrique on 04/10/23.
//

import Foundation

public final class GameStartUseCase: AnyUseCase {
    let session: GameSession
    let roomRepository: RoomRepository
    
    public init(session: GameSession, roomRepository: RoomRepository) {
        self.session = session
        self.roomRepository = roomRepository
    }
    
    public func execute(request: String) async throws -> MasterActingDTO {
        let room = try await roomRepository.findRoomById(request)
        guard let master = room.master else { throw GameSessionError.masterNotFound }
        session.startGame(at: room)
        return MasterActingDTO(master: master)
    }
}
