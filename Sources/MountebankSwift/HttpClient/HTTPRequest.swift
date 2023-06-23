import Foundation

struct HTTPRequest {
    let url: URL
    let method: HTTPMethod
    let body: Data?
    let headers: [HTTPHeaders: String]

    init(url: URL, method: HTTPMethod, body: Data? = nil, headers: [HTTPHeaders: String] = [:]) {
        self.url = url
        self.method = method
        self.body = body
        self.headers = headers
    }
}
