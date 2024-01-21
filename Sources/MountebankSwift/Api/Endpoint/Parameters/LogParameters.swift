import Foundation

/// Parameters for Logs endpoint
public struct LogParameters: EndpointParameters {
    let startIndex: Int?
    let endIndex: Int?

    /// - Parameters:
    ///   - startIndex: Set to array index of the first log entry you want returned.
    ///   - endIndex: Set to the array index of the last log entry you want returned.
    public init(startIndex: Int? = nil, endIndex: Int? = nil) {
        self.startIndex = startIndex
        self.endIndex = endIndex
    }

    public func makeQueryParameters() -> [URLQueryItem] {
        mapQueryParameters(["startIndex": startIndex, "endIndex": endIndex])
    }
}
