import Foundation

extension Stub {
    public enum Response: Codable, Equatable {
        case `is`(Is, Parameters?)
        case proxy(Proxy, Parameters?)
        case inject(String, Parameters?)
        case fault(Fault, Parameters?)
    }
}
