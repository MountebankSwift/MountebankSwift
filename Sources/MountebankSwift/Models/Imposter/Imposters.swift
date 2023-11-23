import Foundation

public struct Imposters: Codable, Equatable {
    public struct ImposterRef: Codable, Equatable {
        public let networkProtocol: NetworkProtocol
        public let port: Int

        enum CodingKeys: String, CodingKey {
            case networkProtocol = "protocol"
            case port
        }
    }

    public let imposters: [ImposterRef]
}
