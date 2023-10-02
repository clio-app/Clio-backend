//
//  File.swift
//  
//
//  Created by Thiago Henrique on 02/10/23.
//

import Foundation
import Vapor

struct SocketConnection {
    let id: UUID
    let socket: WebSocket
}
