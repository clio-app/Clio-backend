//
//  File.swift
//  
//
//  Created by Thiago Henrique on 18/09/23.
//

import Foundation
import FluentKit
import ClioEntities

final class RoomUser: Fields {
    @Field(key: "rankingPosition")
    var rankingPosition: Int
    @Field(key: "points")
    var points: Int
    @Field(key: "didVote")
    var didVote: Bool
    @Field(key: "user")
    var user: User

    convenience init(from entity: ClioEntities.RoomUser) {
        self.init()
        
        self.rankingPosition = entity.rankingPosition
        self.points = entity.points
        self.didVote = entity.didVote
        self.user = User(from: entity.user)
    }
}
