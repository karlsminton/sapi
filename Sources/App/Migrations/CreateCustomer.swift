import Vapor
import Fluent

struct CreateCustomer: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Customer.schema)
            .field("id", .int, .identifier(auto: true))
            .field("username", .string)
            .field("email", .string)
            .field("firstname", .string)
            .field("lastname", .string)
            .field("password", .string)
            .unique(on: "email")
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Customer.schema).delete()
    }
}
