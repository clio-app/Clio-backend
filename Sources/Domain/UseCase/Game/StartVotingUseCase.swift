//
//  File.swift
//  
//
//  Created by Thiago Henrique on 06/10/23.
//

import Foundation
import ClioEntities

public final class StartVotingUseCase: AnyUseCase {
    let session: GameSession
    
    public init(session: GameSession) {
        self.session = session
    }
    
    public func execute(request: UserDidActDTO) -> StartVotingDTO? {
        if request.submitCount != request.totalCount { return nil }
        guard let sessionArtefacts = session.sessionArtefacts else { return nil }
        
        return StartVotingDTO(
            picture: sessionArtefacts.picture,
            descriptions: session.descriptions,
            countdownTimer: session.getTimerForVoting()
        )
    }
}
