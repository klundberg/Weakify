
import XCTest
import Weakify

private class Thing {}
private enum Error: ErrorType { case Error }

class WeakifyTest: XCTestCase {

    private var object: Thing = Thing()
    var executed = false

    override func setUp() {
        super.setUp()

        object = Thing()
        executed = false
    }

    func testVoidToVoidWillExecuteIfNotNil() {
        func f(object: Thing) -> () -> Void {
            return { self.executed = true }
        }

        weakify(object, f)()

        XCTAssertTrue(executed)
    }

    func testVoidThrowsToVoidWillExecuteIfNotNil() {
        func f(object: Thing) -> () throws -> Void {
            return { self.executed = true }
        }

        try! weakify(object, f)()

        XCTAssertTrue(executed)
    }

    
}
