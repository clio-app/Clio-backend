//
//  File.swift
//  
//
//  Created by Thiago Henrique on 06/10/23.
//

import Foundation
import ClioEntities

final public class EndRoundUseCase: AnyUseCase {
    let session: GameSession
    
    public init(session: GameSession) {
        self.session = session
    }
    
    public func execute(request: Void = Void()) -> RoundEndDTO? {
        guard let winner = session.verifyWinnerDescription() else { return nil }
    
        return RoundEndDTO(
            winnerDescription: winner,
            descriptions: session.descriptions,
            ranking: session.players
        )
    }
}
