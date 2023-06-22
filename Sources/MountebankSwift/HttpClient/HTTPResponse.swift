import Foundation

public struct HTTPResponse {

    let body: Data
    let statusCode: HTTPStatusCode
    
    init(body: Data, statusCode: HTTPStatusCode) {
        self.body = body
        self.statusCode = statusCode
    }
}
