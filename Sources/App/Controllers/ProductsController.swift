import Vapor
import Fluent

struct ProductsController: RouteCollection {
    func boot (routes: RoutesBuilder) throws {
        let products = routes.grouped("products")
        products.post(use: create)
        
        products.group(":id") { product in
            product.get(use: index)
            product.put(use: update)
            product.delete(use: delete)
        }
    }
    
    func index(req: Request) throws -> EventLoopFuture<Product.Output> {
        let id = req.parameters.get("id") as Int? ?? nil
        if (id != nil) {
            // todo fix issue here
            return Product.find(id, on: req.db).unwrap(or: Abort(.notFound)).map {
                Product.Output(id: $0.id, name: $0.name, sku: $0.sku, price: $0.price)
            }
        } else {
            throw Abort(.notFound)
        }
    }
    
    func create(req: Request) throws -> EventLoopFuture<Product> {
        let product = try req.content.decode(Product.self)
        return product.create(on: req.db).map { product }
    }
    
    func update(req: Request) throws -> String {
        let id = req.parameters.get("id")! as Int? ?? nil
        let body = req.content
        let product = Product.find(id, on: req.db).unwrap(or: Abort(.badGateway)).map {
            Product(id: $0.id, name: $0.name, sku: $0.sku, price: $0.price)
        }
        //product
        return ""
    }
    
    func delete(req: Request) throws -> String {
        let id = req.parameters.get("id") as Int? ?? nil
        if (id != nil) {
            // todo surely can do this neater - warning occurs about use of map
            Product.find(id, on: req.db).unwrap(or: Abort(.notFound)).map {
                Product(id: $0.id, name: $0.name, sku: $0.sku, price: $0.price).delete(on: req.db)
            }
        } else {
            throw Abort(.notFound)
        }
        return "deleted"
    }
}
