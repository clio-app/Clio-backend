//
//  File.swift
//  
//
//  Created by Thiago Henrique on 18/09/23.
//

import Foundation

public struct RoomUser: Codable {
    public let rankingPosition: Int
    public let points: Int
    public let user: User
}
