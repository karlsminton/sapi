import Vapor
import Fluent

/*
 * Fix with this https://theswiftdev.com/get-started-with-the-fluent-orm-framework-in-vapor-4/
 */
final class Product: Model, Content {
    static let schema = "products"
    
    struct Input: Content {
        let name: String
        let sku: String
        let price: String
    }
    
    struct Output: Content {
        let id: Int?
        let name: String
        let sku: String
        let price: String
    }
    
    @ID(custom: "id")
    var id: Int?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "sku")
    var sku: String
    
    @Field(key: "price")
    var price: String
    
    init() {}
    
    init (
        id: Int? = nil,
        name: String,
        sku: String,
        price: String
    ) {
        self.id = id
        self.name = name
        self.sku = sku
        self.price = price
    }
}
