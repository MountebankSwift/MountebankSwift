import Foundation

public struct Imposters: Codable {
    public struct ImposterRef: Codable {
        public let networkProtocol: NetworkProtocol
        public let port: Int

        enum CodingKeys: String, CodingKey {
            case networkProtocol = "protocol"
            case port
        }
    }

    public let imposters: [ImposterRef]
}
