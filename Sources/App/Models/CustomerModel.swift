import Vapor
import Fluent

final class Customer: Model, Content {
    static let schema = "customers"
    
    struct Input: Content {
        let username: String
        let email: String
        let firstname: String
        let lastname: String
        let password: String
    }
    
    struct Output: Content {
        let id: Int?
        let username: String
        let email: String
        let firstname: String
        let lastname: String
        let password: String
    }
    
    @ID(custom: "id")
    var id: Int?
    
    @Field(key: "username")
    var username: String
    
    @Field(key: "email")
    var email: String
    
    @Field(key: "firstname")
    var firstname: String
    
    @Field(key: "lastname")
    var lastname: String
    
    @Field(key: "password")
    var password: String
    
    init(){}
    
    init(
        id: Int? = nil,
        username: String,
        email: String,
        firstname: String,
        lastname: String,
        password: String
    ) {
        self.id = id
        self.username = username
        self.email = email
        self.firstname = firstname
        self.lastname = lastname
        self.password = password
    }
}
