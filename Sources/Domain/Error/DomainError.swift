//
//  File.swift
//  
//
//  Created by Thiago Henrique on 19/09/23.
//

import Foundation

public enum DomainError: LocalizedError {
    case validationError(String)
    case notFoundError(String)
    case somethingWrong(String)
    
    public var errorDescription: String? {
        switch self {
        case .validationError(let error):
            return error
        case .notFoundError(let error):
            return error
        case .somethingWrong(let error):
            return error
        }
    }
}
