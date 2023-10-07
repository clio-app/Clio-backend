//
//  File.swift
//  
//
//  Created by Thiago Henrique on 04/10/23.
//

import Foundation
import ClioEntities

public protocol GameSession {
    var started: Bool { get }
    var master: RoomUser? { get }
    var sessionArtefacts: SessionArtefacts? { get }
    var players: [RoomUser] { get }
    var descriptions: [Description] { get }

    func startGame(at room: Room)
    func getTimerForMasterData(picture: Data, description: String) -> TimeInterval
    func addDescriptionForPicture(_ description: String, from user: UUID)
    func getTimerForVoting() -> TimeInterval
    func computeUserVote(user: UUID, votedDescription: UUID)
    func verifyWinnerDescription() -> Description? 
    func generateRanking()
}
