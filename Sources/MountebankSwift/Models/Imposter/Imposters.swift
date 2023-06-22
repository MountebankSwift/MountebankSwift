import Foundation

public struct Imposters: Codable {
    public struct ImposterRef: Codable {
        public let scheme: Scheme
        public let port: Int

        enum CodingKeys: String, CodingKey {
            case scheme = "protocol"
            case port
        }
    }

    public let imposters: [ImposterRef]
}
