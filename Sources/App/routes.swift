import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }
    
    try app.register(collection: ProductsController())
    try app.register(collection: CustomersController())
}
