//
//  File.swift
//  
//
//  Created by Thiago Henrique on 19/09/23.
//

import Foundation
import FluentKit

public final class RoomCode: Model {
    public static var schema: String = "roomCodes"

    @ID(key: .id)
    public var id: UUID?
    
    public init(id: UUID? = nil) {
        self.id = id
    }
    
    public init() {}
}
