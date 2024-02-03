import Foundation

extension URL {
    func appending(_ queryItems: [URLQueryItem]) -> URL? {
        guard queryItems.count > 0 else {
            return self
        }

        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return self
        }
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems

        return urlComponents.url
    }
}
