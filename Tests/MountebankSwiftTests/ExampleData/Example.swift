import Foundation
import MountebankSwift

struct Example<CodableEquatableType: Codable & Equatable & Sendable> {
    let value: CodableEquatableType
    let json: JSON
}
