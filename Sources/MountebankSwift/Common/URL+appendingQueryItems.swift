import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension URL {
    /// Appends query items to the current URL. If no query items are provided, returns the original URL.
    ///
    /// - parameters:
    ///    - queryItems: The query items to append.
    ///
    /// - returns: The updated URL with appended query items, or the original URL if no query items were provided.
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
