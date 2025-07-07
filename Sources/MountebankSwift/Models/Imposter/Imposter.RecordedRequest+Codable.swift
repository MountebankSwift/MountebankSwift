import Foundation

extension Imposter.RecordedRequest {
    enum CodingKeys: String, CodingKey, Equatable {
        case method
        case path
        case query
        case headers
        case body
        case form
        case timestamp
        case requestFrom
        case ip
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(method, forKey: .method)
        try container.encodeIfPresent(path, forKey: .path)
        try container.encodeIfPresent(query, forKey: .query)
        try container.encodeIfPresent(headers, forKey: .headers)
        try container.encodeIfPresent(body, forKey: .body)
        try container.encodeIfPresent(form, forKey: .form)
        try container.encode(DateFormatter.shared.formatFromDate(timestamp), forKey: .timestamp)
        try container.encode(requestFrom, forKey: .requestFrom)
        try container.encode(ip, forKey: .ip)

    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        method = try container.decodeIfPresent(HTTPMethod.self, forKey: .method)
        path = try container.decodeIfPresent(String.self, forKey: .path)
        query = try container.decodeIfPresent([String: String].self, forKey: .query)

        headers = try container.decodeIfPresent(
            FailableDictionaryDecodable<String, String>.self, forKey: .headers
        )?.value
        body = try container.decodeIfPresent(JSON.self, forKey: .body)
        form = try container.decodeIfPresent(JSON.self, forKey: .form)

        let timestampString = try container.decode(String.self, forKey: .timestamp)
        timestamp = try DateFormatter.shared.formatToDate(timestampString)
        requestFrom = try container.decode(String.self, forKey: .requestFrom)
        ip = try container.decode(String.self, forKey: .ip)
    }

}
