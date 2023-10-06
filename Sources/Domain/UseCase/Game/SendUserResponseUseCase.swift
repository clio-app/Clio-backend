//
//  File.swift
//  
//
//  Created by Thiago Henrique on 06/10/23.
//

import Foundation
import ClioEntities

public final class SendUserResponseUseCase: AnyUseCase {
    let session: GameSession
    
    public init(session: GameSession) {
        self.session = session
    }
    
    public func execute(request: UserActedDTO) -> UserDidActDTO {
        session.addDescriptionForPicture(request.description, from: request.userId)
        return UserDidActDTO(submitCount: session.descriptions.count)
    }
}
