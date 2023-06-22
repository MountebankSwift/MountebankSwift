import Foundation

public struct HTTPRequest {
    let url: URL
    let method: HTTPMethod
    let body: Data?
    let headers: [HTTPHeaders: String]
}
