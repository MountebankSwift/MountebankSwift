import Foundation

public struct AddStub: Encodable {
    public let index: Int
    public let stub: Stub

    public init(index: Int, stub: Stub) {
        self.index = index
        self.stub = stub
    }
}
