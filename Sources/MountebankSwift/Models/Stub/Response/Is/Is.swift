import Foundation

// swiftlint:disable type_name
/// A regular predefined response. Merges the specified response fields with ``Imposter``.`defaultResponse`
public struct Is: StubResponse, Equatable {

    public static var defaultBehaviors: [Behavior] = []
    public static var defaultHeaders: [String: String] = [:]

    public let statusCode: Int?
    public let headers: [String: String]?
    public let body: Body?

    public let parameters: ResponseParameters?

    public init(
        statusCode: Int? = 200,
        headers: [String: String]? = nil,
        body: Body? = nil,
        parameters: ResponseParameters? = nil
    ) {
        self.statusCode = statusCode
        self.body = body
        self.headers = Self.makeHeaders(headers, body: body)
        self.parameters = Self.makeParameters(parameters)
    }

    private static func makeHeaders(
        _ headers: [String: String]?,
        body: Body?
    ) -> [String: String]? {
        var result = defaultHeaders

        switch body {
        case .none, .text, .data:
            break
        case .json, .jsonEncodable:
            result[HTTPHeaders.contentType.rawValue] = MimeType.json.rawValue
        }

        if let headers {
            result.merge(headers, uniquingKeysWith: { _, b in b })
        }

        return result.isEmpty ? nil : result
    }

    private static func makeParameters(_ parameters: ResponseParameters?) -> ResponseParameters? {
        defaultBehaviors.isEmpty
            ? parameters
            : ResponseParameters(
                repeatCount: parameters?.repeatCount,
                behaviors: Self.defaultBehaviors + (parameters?.behaviors ?? [])
            )
    }
}

extension Is: Recreatable {
    func recreatable(indent: Int) -> String {
        structSwiftString([
            ("statusCode", statusCode),
            ("headers", headers),
            ("body", body),
            ("parameters", parameters),
        ], indent: indent)
    }
}
