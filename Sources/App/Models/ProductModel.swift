import Vapor
import Fluent

/*
 * Fix with this https://theswiftdev.com/get-started-with-the-fluent-orm-framework-in-vapor-4/
 */
final class Product: Model {
    static let schema = "products"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "sku")
    var sku: String
    
    @Field(key: "price")
    var price: String
    
    init() {}
}

struct CreateProduct: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Product.schema)
            .id()
            .field("name", .string)
            .field("sku", .string)
            .field("price", .string)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Product.schema).delete()
    }
}
