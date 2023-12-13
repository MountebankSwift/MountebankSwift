import Foundation

// Convenience overloads for various body types
extension Is {
    public init(
        statusCode: Int = 200,
        headers: [String: String]? = nil,
        body: String,
        parameters: ResponseParameters? = nil
    ) {
        self.init(
            statusCode: statusCode,
            headers: headers,
            body: .text(body),
            parameters: parameters
        )
    }

    public init(
        statusCode: Int = 200,
        headers: [String: String]? = nil,
        body: JSON,
        parameters: ResponseParameters? = nil
    ) {
        self.init(
            statusCode: statusCode,
            headers: headers,
            body: .json(body),
            parameters: parameters
        )
    }

    public init(
        statusCode: Int = 200,
        headers: [String: String]? = nil,
        body: Data,
        parameters: ResponseParameters? = nil
    ) {
        self.init(
            statusCode: statusCode,
            headers: headers,
            body: .data(body),
            parameters: parameters
        )
    }

    public init(
        statusCode: Int = 200,
        headers: [String: String]? = nil,
        body: any Codable,
        parameters: ResponseParameters? = nil
    ) {
        self.init(
            statusCode: statusCode,
            headers: headers,
            body: .jsonEncodable(body),
            parameters: parameters
        )
    }
}

// Convenience overloads for various body types
extension Array where Element == Is {
    public init(
        statusCode: Int = 200,
        headers: [String: String]? = nil,
        bodies: [Body],
        parameters: ResponseParameters? = nil
    ) {
        self = bodies.map { body in
            Is(
                statusCode: statusCode,
                headers: headers,
                body: body,
                parameters: parameters
            )
        }
    }

    public init(
        statusCode: Int = 200,
        headers: [String: String]? = nil,
        bodies: [String],
        parameters: ResponseParameters
    ) {
        self = bodies.map { body in
            Is(
                statusCode: statusCode,
                headers: headers,
                body: body,
                parameters: parameters
            )
        }
    }

    public init(
        statusCode: Int = 200,
        headers: [String: String]? = nil,
        bodies: [JSON],
        parameters: ResponseParameters
    ) {
        self = bodies.map { body in
            Is(
                statusCode: statusCode,
                headers: headers,
                body: body,
                parameters: parameters
            )
        }
    }

    public init(
        statusCode: Int = 200,
        headers: [String: String]? = nil,
        bodies: [Data],
        parameters: ResponseParameters
    ) {
        self = bodies.map { body in
            Is(
                statusCode: statusCode,
                headers: headers,
                body: body,
                parameters: parameters
            )
        }
    }

    public init(
        statusCode: Int = 200,
        headers: [String: String]? = nil,
        bodies: [any Codable],
        parameters: ResponseParameters
    ) {
        self = bodies.map { body in
            Is(
                statusCode: statusCode,
                headers: headers,
                body: body,
                parameters: parameters
            )
        }
    }
}
