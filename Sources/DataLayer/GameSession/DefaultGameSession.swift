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
    public var started: Bool = false 
    
    public init() {}

    public func startGame(at room: Room) {
        self.started = true
    }
    
    public func getTimerForMasterData(picture: Data, description: String) -> TimeInterval {
        return TimeInterval(integerLiteral: 90)
    }
}
