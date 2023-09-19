import DataLayer
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    try configure(app.databases)
    app.migrations.add(CreateTodo())

    // register routes
    try routes(app)
}
