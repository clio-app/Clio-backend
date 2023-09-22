//
//  File.swift
//  
//
//  Created by Thiago Henrique on 18/09/23.
//

import Foundation

public struct User: Codable {
    public let id: UUID
    public let name: String
    public let picture: String
    
    public init(id: UUID, name: String, picture: String) {
        self.id = id
        self.name = name
        self.picture = picture
    }
}
