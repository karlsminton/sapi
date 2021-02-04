import Vapor
import Fluent

struct CartController: RouteCollection {
    func boot (routes: RoutesBuilder) throws {
        let carts = routes.grouped("carts")
        carts.get(use: create)
        
        carts.group(":id") { cart in
            cart.get(use: read)
            cart.post(use: add)
        }
    }
    
    //func create(req: Request) throws -> EventLoopFuture<Cart> {
    func create(req: Request) throws -> String {
        return ""
    }
    
    //func read(req: Request) throws -> EventLoopFuture<Cart> {
    func read(req: Request) throws -> String {
        return ""
    }
    
    //func add(req: Request) throws -> EventLoopFuture<Cart> {
    func add(req: Request) throws -> String {
        return ""
    }
}
