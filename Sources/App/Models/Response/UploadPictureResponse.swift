//
//  File.swift
//  
//
//  Created by Thiago Henrique on 16/10/23.
//

import Foundation
import Vapor

final class UploadPictureResponse: Content {
    let id: String?
    
    init(id: String?) {
        self.id = id
    }
}
