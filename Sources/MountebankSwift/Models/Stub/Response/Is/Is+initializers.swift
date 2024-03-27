import Foundation

// Convenience overloads for various body types
extension Is {

    /// Creates an ``Is`` response from a String
    public init(
        statusCode: Int = 200,
        headers: [String: JSON]? = nil,
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

    /// Creates an ``Is`` response from JSON
    public init(
        statusCode: Int = 200,
        headers: [String: JSON]? = nil,
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

    /// Creates an ``Is`` response from Data
    public init(
        statusCode: Int = 200,
        headers: [String: JSON]? = nil,
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

    /// Creates an ``Is`` response from a codable object
    public init(
        statusCode: Int = 200,
        headers: [String: JSON]? = nil,
        body: any Codable,
        encoder: JSONEncoder? = nil,
        parameters: ResponseParameters? = nil
    ) {
        self.init(
            statusCode: statusCode,
            headers: headers,
            body: .jsonEncodable(body, encoder),
            parameters: parameters
        )
    }
}

// Convenience overloads for various body types
extension Array where Element == Is {
    /// Creates an array of ``Is`` responses
    public init(
        statusCode: Int = 200,
        headers: [String: JSON]? = nil,
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

    /// Creates an array of ``Is`` responses from an array of Strings
    public init(
        statusCode: Int = 200,
        headers: [String: JSON]? = nil,
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

    /// Creates an array of ``Is`` responses from an array of JSON
    public init(
        statusCode: Int = 200,
        headers: [String: JSON]? = nil,
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

    /// Creates an array of ``Is`` responses from an array of Data
    public init(
        statusCode: Int = 200,
        headers: [String: JSON]? = nil,
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

    /// Creates an array of ``Is`` responses from an array of codable objects
    public init(
        statusCode: Int = 200,
        headers: [String: JSON]? = nil,
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
