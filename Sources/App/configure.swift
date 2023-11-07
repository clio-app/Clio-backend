import Vapor
import DataLayer

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    try configure(app.databases)
    // register routes
    try routes(app)
}
