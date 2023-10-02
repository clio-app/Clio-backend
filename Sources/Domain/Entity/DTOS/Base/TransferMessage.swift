//
//  File.swift
//  
//
//  Created by Thiago Henrique on 27/09/23.
//

import Foundation

public struct TransferMessage: Codable {
    public let state: MessageState
    public let data: Data
    
    public init(state: MessageState, data: Data) {
        self.state = state
        self.data = data
    }
    
    public func encodeToTransfer() -> Data {
        return try! JSONEncoder().encode(self)
    }
}
