import Foundation

public struct Imposters: Codable {
    struct ImposterRef: Codable {
        let scheme: Scheme
        let port: Int
        
        enum CodingKeys: String, CodingKey {
            case scheme = "protocol"
            case port
        }
    }

    let imposters: [ImposterRef]
}
