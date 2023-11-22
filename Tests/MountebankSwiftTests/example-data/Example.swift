import Foundation
import MountebankSwift

struct Example<CodableEquatableType: Codable & Equatable> {
    let value: CodableEquatableType
    let json: JSON
}
