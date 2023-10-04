//
//  File.swift
//  
//
//  Created by Thiago Henrique on 04/10/23.
//

import Foundation

public struct MasterActingDTO: DTO {
    let master: RoomUser
    
    public init(master: RoomUser) {
        self.master = master
    }
}
