// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "clio-app-backend",
    platforms: [
       .macOS(.v13)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.77.1"),
        // 🗄 An ORM for SQL and NoSQL databases.
        .package(url: "https://github.com/vapor/fluent.git", from: "4.8.0"),
        // 🪶 Fluent driver for SQLite.
        .package(url: "https://github.com/vapor/fluent-sqlite-driver.git", from: "4.0.0"),
        // Entities
        .package(url: "https://github.com/clio-app/clio-entities", branch: "main"),
    ],
    targets: [
        
        // MARK: - Domain
        .target(name: "Domain", dependencies: [
            .product(name: "ClioEntities", package: "clio-entities")
        ]),
        
        // MARK: - Data
        .target(name: "DataLayer", dependencies: [
            .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
            .product(name: "ClioEntities", package: "clio-entities"),
            "Domain"
        ]),
        
        // MARK: - App
        .executableTarget(
            name: "App",
            dependencies: [
                .product(name: "Fluent", package: "fluent"),
                .product(name: "Vapor", package: "vapor"),
                .product(name: "ClioEntities", package: "clio-entities"),
                "DataLayer",
                "Domain"
            ]
        ),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
