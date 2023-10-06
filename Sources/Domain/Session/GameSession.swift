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
    var descriptions: [Description] { get }

    func startGame(at room: Room)
    func getTimerForMasterData(picture: Data, description: String) -> TimeInterval
    func addDescriptionForPicture(_ description: String, from user: UUID)
}
