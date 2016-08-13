
import XCTest
import Weakify

private class Thing {}
private enum TestError: ErrorType { case Error }

class WeakifyTest: XCTestCase {

    private var object: Thing!
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

    func testVoidToVoidWillNotExecuteIfNil() {
        func f(object: Thing) -> () -> Void {
            return { self.executed = true }
        }

        let fn = weakify(object, f)
        object = nil
        fn()

        XCTAssertFalse(executed)
    }

    func testVoidThrowsToVoidWillNotExecuteIfNil() {
        func f(object: Thing) -> () throws -> Void {
            return { self.executed = true }
        }

        let fn = weakify(object, f)
        object = nil
        try! fn()

        XCTAssertFalse(executed)
    }

    func testVoidThrowsToVoidWillThrowIfNotNil() {
        func f(object: Thing) -> () throws -> Void {
            return { throw TestError.Error }
        }

        XCTAssertThrowsError(try weakify(object, f)())
    }

    func testUToVoidIgnoringUWillExecuteIfNotNil() {
        func f(object: Thing) -> () -> Void {
            return { self.executed = true }
        }

        let fn: Any -> Void = weakify(object, f)
        fn(123)

        XCTAssertTrue(executed)
    }

    func testUThrowsToVoidIgnoringUWillExecuteIfNotNil() {
        func f(object: Thing) -> () throws -> Void {
            return { self.executed = true }
        }

        let fn: Any throws -> Void = weakify(object, f)
        try! fn(123)

        XCTAssertTrue(executed)
    }

    func testUToVoidIgnoringUWillNotExecuteIfNil() {
        func f(object: Thing) -> () -> Void {
            return { self.executed = true }
        }

        let fn: Any -> Void = weakify(object, f)
        object = nil
        fn(123)

        XCTAssertFalse(executed)
    }

    func testUThrowsToVoidIgnoringUWillNotExecuteIfNil() {
        func f(object: Thing) -> () throws -> Void {
            return { self.executed = true }
        }

        let fn: Any throws -> Void = weakify(object, f)
        object = nil
        try! fn(123)

        XCTAssertFalse(executed)
    }

    func testUThrowsToVoidIgnoringUWillThrowIfNotNil() {
        func f(object: Thing) -> () throws -> Void {
            return { throw TestError.Error }
        }

        let fn: Any throws -> Void = weakify(object, f)

        XCTAssertThrowsError(try fn(123))
    }
}
