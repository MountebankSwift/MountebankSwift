import Foundation

extension Stub.Response {
    public struct Is: Codable, Equatable {
        let statusCode: Int
        let headers: [String: String]?
        let body: Body?
        
        public init(statusCode: Int, headers: [String : String]? = nil, body: Body) {
            self.statusCode = statusCode
            self.headers = headers
            self.body = body
        }
        
        public init(statusCode: Int, headers: [String : String]? = nil) {
            self.statusCode = statusCode
            self.headers = headers
            self.body = nil
        }
        
        public init(statusCode: Int, headers: [String : String]? = nil, body: String) {
            self.statusCode = statusCode
            self.headers = headers
            self.body = .text(body)
        }
        
        public init(statusCode: Int, headers: [String : String]? = nil, body: JSON) {
            self.statusCode = statusCode
            self.headers = headers
            self.body = .json(body)
        }
        
        public init(statusCode: Int, headers: [String : String]? = nil, body: Data) {
            self.statusCode = statusCode
            self.headers = headers
            self.body = .data(body)
        }
    }
}
