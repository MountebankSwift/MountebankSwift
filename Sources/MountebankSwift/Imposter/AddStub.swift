import Foundation

public struct AddStub: Encodable {
    let index: Int
    let stub: Stub
    
    public init(index: Int, stub: Stub) {
        self.index = index
        self.stub = stub
    }
}
