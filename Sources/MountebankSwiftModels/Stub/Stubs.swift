import Foundation

package struct Stubs: Codable, Equatable {
    let stubs: [Stub]
    
    package init(stubs: [Stub]) {
        self.stubs = stubs
    }
}
