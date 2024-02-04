import Foundation

public protocol EndpointParameters {
    func makeQueryParameters() -> [URLQueryItem]
}

extension EndpointParameters {
    func mapQueryParameters(_ parameters: [String: LosslessStringConvertible?]) -> [URLQueryItem] {
        parameters.map { key, value in
            guard let value else {
                return nil
            }
            return URLQueryItem(name: key, value: String(value))
        }.compactMap { $0 }
    }
}
