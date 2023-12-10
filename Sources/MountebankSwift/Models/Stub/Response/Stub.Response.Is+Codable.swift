import Foundation

extension Stub.Response.Is {
    enum DecodingError: Error {
        case invalidBodyForTextBodyMode
        case invalidBodyForBinaryBodyMode
    }

    enum CodingKeys: String, CodingKey {
        case `is`
        case statusCode
        case headers
        case body
        case mode = "_mode"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(statusCode, forKey: .statusCode)
        try container.encodeIfPresent(headers, forKey: .headers)

        switch body {
        case .none:
            break
        case .text(let value):
            try container.encode(value, forKey: .body)
        case .json(let json):
            try container.encode(json, forKey: .body)
        case .data(let data):
            try container.encode(Stub.Response.Mode.binary, forKey: .mode)
            try container.encode(data, forKey: .body)
        case .jsonEncodable(let value):
            try container.encode(value, forKey: .body)
        }
    }

    public init(from decoder: Decoder) throws {
        parameters = nil
        let container = try decoder.container(keyedBy: CodingKeys.self)

        statusCode = try container.decode(Int.self, forKey: .statusCode)
        headers = try container.decodeIfPresent([String: String].self, forKey: .headers)

        contentType = headers?[HTTPHeaders.contentType.rawValue]

        let mode = try container.decodeIfPresent(Stub.Response.Mode.self, forKey: .mode)

        guard container.contains(.body) else {
            body = nil
            return
        }

        switch mode {
        case .none, .text:
            if let text = try? container.decode(String.self, forKey: .body) {
                body = .text(text)
            } else if let json = try? container.decode(JSON.self, forKey: .body) {
                body = .json(json)
            } else {
                throw DecodingError.invalidBodyForTextBodyMode
            }
        case .binary:
            if let data = try? container.decode(Data.self, forKey: .body) {
                body = .data(data)
            } else {
                throw DecodingError.invalidBodyForBinaryBodyMode
            }
        }
    }
}
