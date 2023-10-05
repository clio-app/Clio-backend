//
//  File.swift
//  
//
//  Created by Thiago Henrique on 04/10/23.
//

import Foundation

enum GameSessionError: LocalizedError {
    case masterNotFound
    
    var errorDescription: String? {
        switch self {
            case .masterNotFound:
                return "Sala sem mestre"
        }
    }
}
