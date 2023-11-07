//
//  File.swift
//  
//
//  Created by Thiago Henrique on 06/11/23.
//

import Foundation
import ClioEntities

public final class ChooseMasterUseCase: AnyUseCase {
    let session: GameSession

    public init(session: GameSession) {
        self.session = session
    }
    
    public func execute(request: ChooseMasterDTO) -> MasterChoosedDTO {
        session.changeSessionMaster()
        
        return MasterChoosedDTO(
            reason: request.reason,
            countdownTimer: TimeInterval(integerLiteral: 300),
            user: session.master!
        )
    }
}
