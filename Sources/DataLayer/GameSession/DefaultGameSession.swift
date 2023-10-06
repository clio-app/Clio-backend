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
    public private(set) var started: Bool = false
    public private(set) var descriptions: [Description] = []
    
    public init() {}

    public func startGame(at room: Room) {
        self.started = true
    }
    
    public func getTimerForMasterData(picture: Data, description: String) -> TimeInterval {
        return TimeInterval(integerLiteral: 90)
    }
    
    public func addDescriptionForPicture(_ description: String, from user: UUID) {
        descriptions.append(
            Description(
                id: UUID(),
                userID: user,
                text: description,
                voteCount: nil
            )
        )
    }
}
