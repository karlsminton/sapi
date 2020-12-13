import Vapor

struct ProductsController: RouteCollection {
    func boot (routes: RoutesBuilder) throws {
        let products = routes.grouped("products")
        products.get(use: index)
        products.post(use: create)
        
        products.group(":id") { product in
            product.get(use: index)
            product.put(use: update)
            product.delete(use: delete)
        }
    }
    
    func index(req: Request) throws -> String {
        var response = "resp"
        let id = req.parameters.get("id") ?? "empty"
        if (id != "empty") {
            response = id;
        } else {
            response = "barry"
        }
        return response;
    }
    
    func create(req: Request) throws -> String {
        return "created"
    }
    
    func update(req: Request) throws -> String {
        return "updated"
    }
    
    func delete(req: Request) throws -> String {
        return "deleted"
    }
}
