//
//  File.swift
//  
//
//  Created by Thiago Henrique on 04/10/23.
//

import Foundation

public protocol GameSession {
    var started: Bool { get }

    func startGame(at room: Room)
    func getTimerForMasterData(picture: Data, description: String) -> TimeInterval
}
