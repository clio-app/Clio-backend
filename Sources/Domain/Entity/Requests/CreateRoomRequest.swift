//
//  File.swift
//  
//
//  Created by Thiago Henrique on 20/09/23.
//

import Foundation

public struct CreateRoomRequest: Codable {
    public let name: String
    public let theme: Theme
}
