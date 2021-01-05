import Vapor
import Fluent

struct CreateProduct: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Product.schema)
            //.id()
            .field("id", .int, .identifier(auto: true))
            .field("name", .string)
            .field("sku", .string)
            .field("price", .string)
            .unique(on: "sku")
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Product.schema).delete()
    }
}
