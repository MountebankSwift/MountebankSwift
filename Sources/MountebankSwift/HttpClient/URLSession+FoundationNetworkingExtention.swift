import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking

extension URLSession {
    public func data(
        for request: URLRequest, delegate: (any URLSessionTaskDelegate)? = nil
    ) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: request) { data, response, error in
                if let error {
                    continuation.resume(throwing: error)
                }
                guard let data, let response else {
                    return
                }
                continuation.resume(returning: (data, response))
            }
            task.resume()
        }
    }
}
#endif
