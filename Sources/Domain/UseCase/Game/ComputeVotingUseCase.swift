//
//  File.swift
//  
//
//  Created by Thiago Henrique on 06/10/23.
//

import Foundation
import ClioEntities

public final class ComputeVotingUseCase: AnyUseCase {
    let session: GameSession
    
    public init(session: GameSession) {
        self.session = session
    }
    
    public func execute(request: UserVotedDTO) -> UserDidVoteDTO {
        session.computeUserVote(
            user: request.votedUserId,
            votedDescription: request.descriptionId
        )
        
        return UserDidVoteDTO(
            descriptionId: request.descriptionId,
            submitVotes: session.players.filter { $0.didVote == true }.count,
            totalVotes: session.players.count
        )
    }
}
