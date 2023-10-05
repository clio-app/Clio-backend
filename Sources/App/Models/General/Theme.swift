//
//  File.swift
//  
//
//  Created by Thiago Henrique on 18/09/23.
//

import Foundation
import FluentKit
import ClioEntities

final class Theme: Fields {
    @Field(key: "title")
    var title: String
    
    convenience init(from entity: ClioEntities.Theme) {
        self.init()
        
        self.title = entity.title
    }
}
