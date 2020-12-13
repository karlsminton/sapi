import Vapor
import Fluent
import FluentProvider

final class Product: Model {
    var storage = Storage()
    var name: String
    var price: String
    var sku: String
    
    init(
        name: String,
        price: String,
        sku: String
    ) {
        self.name = name
        self.price = price
        self.sku = sku
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set("name", name)
        try row.set("price", price)
        try row.set("sku", sku)
        return row
    }
    
    init(row: Row) throws {
        self.name = try row.get("name")
        self.price = try row.get("price")
        self.sku = try row.get("sku")
    }
}
