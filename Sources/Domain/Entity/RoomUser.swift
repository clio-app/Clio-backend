//
//  File.swift
//  
//
//  Created by Thiago Henrique on 18/09/23.
//

import Foundation

public struct RoomUser: Codable {
    let rankingPosition: Int
    let points: Int
    let user: User
}
