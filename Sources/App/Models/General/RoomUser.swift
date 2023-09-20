//
//  File.swift
//  
//
//  Created by Thiago Henrique on 18/09/23.
//

import Foundation
import FluentKit
import Domain

final class RoomUser: Fields {
    @Field(key: "rankingPosition")
    var rankingPosition: Int
    @Field(key: "points")
    var points: Int
    @Field(key: "user")
    var user: User

    convenience init(from domain: Domain.RoomUser) {
        self.init()
        
        self.rankingPosition = domain.rankingPosition
        self.points = domain.points
        self.user = User(from: domain.user)
    }
}
