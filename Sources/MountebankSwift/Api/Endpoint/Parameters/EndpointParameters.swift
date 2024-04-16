import Foundation

protocol EndpointParameters: Sendable {
    func makeQueryParameters() -> [URLQueryItem]
}

extension EndpointParameters {
    func mapQueryParameters(_ parameters: [String: LosslessStringConvertible?]) -> [URLQueryItem] {
        parameters
            .sorted(by: { $0.key < $1.key })
            .compactMap { key, value in
                value.map { URLQueryItem(name: key, value: String($0)) }
            }
    }
}
