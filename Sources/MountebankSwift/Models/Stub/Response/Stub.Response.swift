import Foundation

extension Stub {
    public enum Response: Codable, Equatable {
        case `is`(Is, Parameters? = nil)
        case proxy(Proxy, Parameters? = nil)
        case inject(String, Parameters? = nil)
        case fault(Fault, Parameters? = nil)
    }
}
