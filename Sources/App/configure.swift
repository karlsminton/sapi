import Vapor
import Fluent
import FluentMySQLDriver

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.databases.use(.mysql(hostname: "localhost", username: "root", password: "root", database: "vapor"), as: .mysql)

    // register routes
    try routes(app)
}
