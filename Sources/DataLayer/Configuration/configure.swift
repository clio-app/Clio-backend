//
//  File.swift
//  
//
//  Created by Thiago Henrique on 18/09/23.
//

import Foundation
import FluentSQLiteDriver
import FluentKit

public func configure(_ databases: Databases) throws {
    databases.use(DatabaseConfigurationFactory.sqlite(.file("db.sqlite")), as: .sqlite)
}
