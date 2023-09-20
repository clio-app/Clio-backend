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
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
