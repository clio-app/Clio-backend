//
//  File.swift
//  
//
//  Created by Thiago Henrique on 19/09/23.
//

import Foundation
import FluentKit
import Vapor

public final class CreateRoomResponse: Model, Content {
    public static var schema: String = "roomCodes"

    @ID(custom: "id")
    public var id: String?

    public init(id: String? = nil) { self.id = id }
    public init() {}
}
