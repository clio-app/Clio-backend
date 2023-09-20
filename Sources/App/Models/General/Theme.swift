//
//  File.swift
//  
//
//  Created by Thiago Henrique on 18/09/23.
//

import Foundation
import FluentKit
import Domain

final class Theme: Fields {
    @Field(key: "title")
    var title: String
    
    convenience init(from domain: Domain.Theme) {
        self.init()
        
        self.title = domain.title
    }
}
