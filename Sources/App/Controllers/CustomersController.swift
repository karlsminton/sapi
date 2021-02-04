import Vapor
import Fluent

struct CustomersController: RouteCollection {
    func boot (routes: RoutesBuilder) throws {
        let customer = routes.grouped("customer")
        customer.post(use: create)
        
        customer.group(":id") { customer in
            customer.get(use: read)
            customer.delete(use: delete)
        }
    }
    
    func create(req: Request) throws -> EventLoopFuture<Customer> {
        let customer = try req.content.decode(Customer.self)
        return customer.create(on: req.db).map { customer }
    }
    
    func read(req: Request) throws -> EventLoopFuture<Customer.Output> {
        let id = req.parameters.get("id") as Int? ?? nil
        if (id != nil) {
            return Customer.find(id, on: req.db).unwrap(or: Abort(.notFound)).map {
                Customer.Output(
                    id: $0.id,
                    username: $0.username,
                    email: $0.email,
                    firstname: $0.firstname,
                    lastname: $0.lastname,
                    password: $0.password
                )
            }
        }
        throw Abort(.notFound)
    }
    
    func delete(req: Request) throws -> String {
        let id = req.parameters.get("id") as Int? ?? nil
        if (id != nil) {
            Customer.find(id, on: req.db).unwrap(or: Abort(.notFound)).map {
                //$0.delete(on: req.db)
                Customer(
                    id: $0.id,
                    username: $0.username,
                    email: $0.email,
                    firstname: $0.firstname,
                    lastname: $0.lastname,
                    password: $0.password
                ).delete(on: req.db)
            }
            return "deleted"
        }
        throw Abort(.notFound)
    }
}
