import Vapor

class HeadersMiddleware: Middleware {
    func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        return next.respond(to: request).map { response in
            response.headers.add(name: "Access-Control-Allow-Origin", value: "*")
            return response
        }
    }
}
