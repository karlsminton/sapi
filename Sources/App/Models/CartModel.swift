import Vapor
import Fluent

final class Cart: Model, Content {
    static let schema = "carts"
    
    struct Input: Content {
        let id: Int?
    }
    
    struct Output: Content {
        let id: Int?
    }
    
    @ID(custom: "id")
    var id: Int?
    
    init(){}
}
