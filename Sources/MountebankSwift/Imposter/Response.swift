import Foundation

// // https://www.mbtest.org/docs/api/contracts
public enum Response: Encodable {
    public enum Mode: Encodable {
        case text
        case binary
    }

    public struct Is: Encodable {
        let statusCode: Int
        let headers: [String: String] // TODO more type safe?
        let body: String // or (JSON) object
        let mode: Mode

        enum CodingKeys: String, CodingKey {
            case statusCode
            case headers
            case body
            case mode = "_mode"
        }

        init(statusCode: Int = 200, headers: [String : String] = [:], body: String = "", mode: Mode = .text) {
            self.statusCode = statusCode
            self.headers = headers
            self.body = body
            self.mode = mode
        }
    }

    public struct Proxy: Encodable {
        // TODO
    }
    public struct Inject: Encodable {
        // TODO
    }

    public struct Parameters: Encodable {
        let `repeat`: Int

        init(repeatCount: Int) {
            self.repeat = repeatCount
        }
    }

    case `is`(Is, Parameters)
    // case proxy(Proxy, Parameters)
    // case inject(Inject, Parameters)
}
