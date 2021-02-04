import Vapor
import Fluent
import FluentMySQLDriver

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
//    app.middleware.use(HeadersMiddleware())
//    app.middleware.use(CORSMiddleware())
    
    
    
    
    let corsConfiguration = CORSMiddleware.Configuration(
        allowedOrigin: .all,
        allowedMethods: [.GET, .POST, .PUT, .OPTIONS, .DELETE, .PATCH],
        allowedHeaders: [.accept, .authorization, .contentType, .origin, .xRequestedWith, .userAgent, .accessControlAllowOrigin]
    )
    let cors = CORSMiddleware(configuration: corsConfiguration)

    // Only add this if you want to enable the default per-route logging
    let routeLogging = RouteLoggingMiddleware(logLevel: .info)

    // Add the default error middleware
    let error = ErrorMiddleware.default(environment: app.environment)
    // Clear any existing middleware.
    app.middleware = .init()
    app.middleware.use(cors)
    app.middleware.use(routeLogging)
    app.middleware.use(error)
    
    
    
    //todo - remove the "certificateVerification: .none" for production
    app.databases.use(.mysql(hostname: "127.0.0.1", username: "root", password: "", database: "vapor", tlsConfiguration: .forClient(certificateVerification: .none)), as: .mysql)

    app.migrations.add(CreateProduct())
    app.migrations.add(CreateCustomer())
    // register routes
    try routes(app)
}
