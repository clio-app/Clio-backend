//
//  File.swift
//  
//
//  Created by Thiago Henrique on 19/09/23.
//

import Foundation

public struct RoomCode: Codable {
    public let code: UUID
    
    public init(code: UUID) { self.code = code }
}
