import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }
    
//    app.get("product") { req in
//        return "Product Url"
//    }
    try app.register(collection: ProductsController())
}
