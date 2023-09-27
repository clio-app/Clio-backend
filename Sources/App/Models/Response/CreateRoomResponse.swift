//
//  File.swift
//  
//
//  Created by Thiago Henrique on 19/09/23.
//

import Foundation
import Vapor
    
final class CreateRoomResponse: Content {
    let id: String?
    
    init(id: String?) {
        self.id = id
    }
}
