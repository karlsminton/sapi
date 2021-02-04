import Vapor
import Fluent

struct ProductsController: RouteCollection {
    func boot (routes: RoutesBuilder) throws {
        let products = routes.grouped("products")
        products.post(use: create)
        products.get(use: index)
        
        products.group(":id") { product in
            product.get(use: read)
            products.put(use: update)
            product.delete(use: delete)
        }
    }
    
    func index(req: Request) throws -> EventLoopFuture<[Product]> {
        return Product.query(on: req.db).all()
    }
    
    func read(req: Request) throws -> EventLoopFuture<Product.Output> {
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
    
    func update(req: Request) throws -> EventLoopFuture<Product.Output> {
        let id = req.parameters.get("id") as Int? ?? 0
        let product = try req.content.decode(Product.Input.self)
        
        return Product.find(id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { prod in
                prod.name = product.name
                prod.sku = product.sku
                prod.price = product.price
                return prod.save(on: req.db)
                    .map {Product.Output(id: prod.id, name: prod.name, sku: prod.sku, price: prod.price)}
            }
    }
    
    /*
     
     func update(req: Request) throws -> EventLoopFuture<Todo.Output> {
             guard let id = req.parameters.get("id", as: UUID.self) else {
                 throw Abort(.badRequest)
             }
             let input = try req.content.decode(Todo.Input.self)
             return Todo.find(id, on: req.db)
                 .unwrap(or: Abort(.notFound))
                 .flatMap { todo in
                     todo.title = input.title
                     return todo.save(on: req.db)
                         .map { Todo.Output(id: todo.id!.uuidString, title: todo.title) }
                 }
         }
     
     */
    
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
