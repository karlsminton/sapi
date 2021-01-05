import Vapor
import Fluent
import FluentMySQLDriver

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    //todo - remove the "certificateVerification: .none" for production
    app.databases.use(.mysql(hostname: "127.0.0.1", username: "root", password: "", database: "vapor", tlsConfiguration: .forClient(certificateVerification: .none)), as: .mysql)

    app.migrations.add(CreateProduct())
    // register routes
    try routes(app)
}
