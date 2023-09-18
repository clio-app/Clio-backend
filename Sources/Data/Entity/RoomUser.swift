//
//  File.swift
//  
//
//  Created by Thiago Henrique on 18/09/23.
//

import Foundation
import FluentKit

final class RoomUser: Fields {
    @Field(key: "rankingPosition")
    var rankingPosition: Int
    @Field(key: "points")
    var points: Int
    @Field(key: "user")
    var user: User
}
