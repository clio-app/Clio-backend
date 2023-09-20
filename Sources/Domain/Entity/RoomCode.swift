//
//  File.swift
//  
//
//  Created by Thiago Henrique on 19/09/23.
//

import Foundation

public struct RoomCode: Codable {
    public let code: String
    
    public init(code: String) { self.code = code }
}
