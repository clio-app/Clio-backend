//
//  File.swift
//  
//
//  Created by Thiago Henrique on 04/10/23.
//

import Foundation
import Domain
import ClioEntities

public class DefaultGameSession: GameSession {
    public var sessionArtefacts: SessionArtefacts? = nil
    public private(set) var started: Bool = false
    public private(set) var master: RoomUser? = nil
    public private(set) var players: [RoomUser] = []
    public private(set) var descriptions: [Description] = []
    
    public init() {}

    public func startGame(at room: Room) {
        self.players = room.participants
        self.master = room.master
        self.started = true
    }
    
    public func getTimerForMasterData(picture: Data, description: String) -> TimeInterval {
        sessionArtefacts = SessionArtefacts(
            picture: picture,
            description: description,
            masterId: master?.user.id ?? UUID()
        )
        
        return TimeInterval(integerLiteral: 90)
    }
    
    public func addDescriptionForPicture(_ description: String, from user: UUID) {
        descriptions.append(
            Description(
                id: UUID(),
                userID: user,
                text: description,
                voteCount: 0
            )
        )
    }
    
    public func getTimerForVoting() -> TimeInterval {
        return TimeInterval(integerLiteral: 90)
    }
    
    public func computeUserVote(user: UUID, votedDescription: UUID) {
        guard let playerIndex = players.firstIndex(
            where: { $0.user.id == user }
        ) else { return }
        guard let descriptionIndex = descriptions.firstIndex(
            where: { $0.id == votedDescription }
        ) else { return }
        
        players[playerIndex].didVote = true
        descriptions[descriptionIndex].voteCount += 1
    }
}
