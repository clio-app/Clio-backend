//
//  File.swift
//  
//
//  Created by Thiago Henrique on 19/09/23.
//

import Foundation

public protocol AnyUseCase {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request) async throws -> Response
}
