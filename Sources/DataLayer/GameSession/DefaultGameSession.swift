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
    
    public func verifyWinnerDescription() -> Description? {
        if players.filter({ $0.didVote == true }).count != players.count { return nil }
        
        guard let winnerDescription = descriptions.sorted(
            by: { $0.voteCount > $1.voteCount }
        ).first else {
            return nil
        }
        
        generateRanking()

        return winnerDescription
    }
    
    public func generateRanking() {
        for description in descriptions {
            guard let playerIndex = players.firstIndex(where: {
                $0.user.id == description.userID
            }) else { continue }
            players[playerIndex].points += (description.voteCount * 100)
        }
        
        players = players.sorted(by: { $0.points > $1.points } )
        
        var rankingPosition = 1
        
        for player in players {
            if player.rankingPosition != 0 { continue }
            let tiedPlayers = players.filter( { $0.points == player.points } )
            
            for tiedPlayer in tiedPlayers {
                let playerIndex = players.firstIndex(where: { $0.user.id == tiedPlayer.user.id })!
                players[playerIndex].rankingPosition = rankingPosition
            }
            rankingPosition += 1
        }
    }
}
