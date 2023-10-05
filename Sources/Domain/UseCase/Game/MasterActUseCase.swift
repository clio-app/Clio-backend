//
//  File.swift
//  
//
//  Created by Thiago Henrique on 05/10/23.
//

import Foundation

public final class MasterActUseCase: AnyUseCase {
    let session: GameSession
    
    public init(session: GameSession) {
        self.session = session
    }
    
    public func execute(request: MasterActedDTO) -> MasterSharingDTO {
        return MasterSharingDTO(
            countdownTimer: session.getTimerForMasterData(
                picture: request.picture,
                description: request.description
            ),
            picture: request.picture
        )
    }
}
