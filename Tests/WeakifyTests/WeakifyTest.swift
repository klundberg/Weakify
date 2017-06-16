//  Copyright (c) 2015-2017 Kevin Lundberg. See LICENSE file for more info

import XCTest
import Weakify

private class Thing {}

private struct TestError: Error {}

class WeakifyTest: XCTestCase {

    private var object: Thing!
    private var executed = false

    override func setUp() {
        super.setUp()

        object = Thing()
        executed = false
    }

    // MARK: - () -> Void

    func testVoidToVoid_PartiallyApplied_WillExecuteIfNotNil() {
        func f(o object: Thing) -> () -> Void {
            return { self.executed = true }
        }

        weakify(object, f)()

        XCTAssertTrue(executed)
    }

    func testVoidToVoid_WillExecuteIfNotNil() {
        func f(o object: Thing) -> Void {
            self.executed = true
        }

        weakify(object, f)()

        XCTAssertTrue(executed)
    }

    func testVoidThrowsToVoid_PartiallyApplied_WillExecuteIfNotNil() throws {
        func f(o object: Thing) -> () throws -> Void {
            return { self.executed = true }
        }

        try weakify(object, f)()

        XCTAssertTrue(executed)
    }

    func testVoidThrowsToVoid_WillExecuteIfNotNil() throws {
        func f(o object: Thing) throws -> Void {
            self.executed = true
        }

        try weakify(object, f)()

        XCTAssertTrue(executed)
    }

    func testVoidToVoid_PartiallyApplied_WillNotExecuteIfNil() {
        func f(o object: Thing) -> () -> Void {
            return { self.executed = true }
        }

        let fn: () -> () = weakify(object, f)
        object = nil
        fn()

        XCTAssertFalse(executed)
    }

    func testVoidToVoid_WillNotExecuteIfNil() {
        func f(o object: Thing) -> Void {
            self.executed = true
        }

        let fn: () -> () = weakify(object, f)
        object = nil
        fn()

        XCTAssertFalse(executed)
    }

    func testVoidThrowsToVoid_PartiallyApplied_WillNotExecuteIfNil() throws {
        func f(o object: Thing) -> () throws -> Void {
            return { self.executed = true }
        }

        let fn: () throws -> () = weakify(object, f)
        object = nil
        try fn()

        XCTAssertFalse(executed)
    }

    func testVoidThrowsToVoid_WillNotExecuteIfNil() throws {
        func f(o object: Thing) throws -> Void {
            self.executed = true
        }

        let fn: () throws -> () = weakify(object, f)
        object = nil
        try fn()

        XCTAssertFalse(executed)
    }

    func testVoidThrowsToVoid_PartiallyApplied_WillThrowIfNotNil() {
        func f(o object: Thing) -> () throws -> Void {
            return { throw TestError() }
        }

        XCTAssertThrowsError(try weakify(object, f)())
    }

    func testVoidThrowsToVoid_WillThrowIfNotNil() {
        func f(o object: Thing) throws -> Void {
            throw TestError()
        }

        XCTAssertThrowsError(try weakify(object, f)())
    }

    // MARK: - U -> Void (ignoring U)

    func testUToVoidIgnoringU_PartiallyApplied_WillExecuteIfNotNil() {
        func f(o object: Thing) -> () -> Void {
            return { self.executed = true }
        }

        let fn: (Any) -> Void = weakify(object, f)
        fn(123)

        XCTAssertTrue(executed)
    }

    func testUToVoidIgnoringU_WillExecuteIfNotNil() {
        func f(o object: Thing) -> Void {
            self.executed = true
        }

        let fn: (Any) -> Void = weakify(object, f)
        fn(123)

        XCTAssertTrue(executed)
    }

    func testUThrowsToVoidIgnoringU_PartiallyApplied_WillExecuteIfNotNil() throws {
        func f(o object: Thing) -> () throws -> Void {
            return { self.executed = true }
        }

        let fn: (Any) throws -> Void = weakify(object, f)
        try fn(123)

        XCTAssertTrue(executed)
    }

    func testUThrowsToVoidIgnoringU_WillExecuteIfNotNil() throws {
        func f(o object: Thing) throws -> Void {
            self.executed = true
        }

        let fn: (Any) throws -> Void = weakify(object, f)
        try fn(123)

        XCTAssertTrue(executed)
    }

    func testUToVoidIgnoringU_PartiallyApplied_WillNotExecuteIfNil() {
        func f(o object: Thing) -> () -> Void {
            return { self.executed = true }
        }

        let fn: (Any) -> Void = weakify(object, f)
        object = nil
        fn(123)

        XCTAssertFalse(executed)
    }

    func testUToVoidIgnoringU_WillNotExecuteIfNil() {
        func f(o object: Thing) -> Void {
            self.executed = true
        }

        let fn: (Any) -> Void = weakify(object, f)
        object = nil
        fn(123)

        XCTAssertFalse(executed)
    }

    func testUThrowsToVoidIgnoringU_PartiallyApplied_WillNotExecuteIfNil() throws {
        func f(o object: Thing) -> () throws -> Void {
            return { self.executed = true }
        }

        let fn: (Any) throws -> Void = weakify(object, f)
        object = nil
        try fn(123)

        XCTAssertFalse(executed)
    }

    func testUThrowsToVoidIgnoringU_WillNotExecuteIfNil() throws {
        func f(o object: Thing) throws -> Void {
            self.executed = true
        }

        let fn: (Any) throws -> Void = weakify(object, f)
        object = nil
        try fn(123)

        XCTAssertFalse(executed)
    }

    func testUThrowsToVoidIgnoringU_PartiallyApplied_WillThrowIfNotNil() {
        func f(o object: Thing) -> () throws -> Void {
            return { throw TestError() }
        }

        let fn: (Any) throws -> Void = weakify(object, f)

        XCTAssertThrowsError(try fn(123))
    }

    func testUThrowsToVoidIgnoringU_WillThrowIfNotNil() {
        func f(o object: Thing) throws -> Void {
            throw TestError()
        }

        let fn: (Any) throws -> Void = weakify(object, f)

        XCTAssertThrowsError(try fn(123))
    }

    // MARK: - U -> Void

    func testUToVoid_PartiallyApplied_WillExecuteIfNotNil() {
        func f(o object: Thing) -> (Int) -> Void {
            return { int in self.executed = true }
        }

        weakify(object, f)(123)

        XCTAssertTrue(executed)
    }

    func testUToVoid_WillExecuteIfNotNil() {
        func f(o object: Thing, i: Int) -> Void {
            self.executed = true
        }

        weakify(object, f)(123)

        XCTAssertTrue(executed)
    }

    func testUThrowsToVoid_PartiallyApplied_WillExecuteIfNotNil() {
        func f(o object: Thing) -> (Int) throws -> Void {
            return { int in self.executed = true }
        }

        try! weakify(object, f)(123)

        XCTAssertTrue(executed)
    }

    func testUThrowsToVoid_WillExecuteIfNotNil() throws {
        func f(o object: Thing, i: Int) throws -> Void {
            self.executed = true
        }

        try weakify(object, f)(123)

        XCTAssertTrue(executed)
    }

    func testUToVoid_PartiallyApplied_WillNotExecuteIfNil() {
        func f(o object: Thing) -> (Int) -> Void {
            return { int in self.executed = true }
        }

        let fn: (Int) -> Void = weakify(object, f)
        object = nil
        fn(123)

        XCTAssertFalse(executed)
    }

    func testUToVoid_WillNotExecuteIfNil() {
        func f(o object: Thing, i: Int) -> Void {
            self.executed = true
        }

        let fn = weakify(object, f)
        object = nil
        fn(123)

        XCTAssertFalse(executed)
    }

    func testUThrowsToVoid_PartiallyApplied_WillNotExecuteIfNil() throws {
        func f(o object: Thing) -> (Int) throws -> Void {
            return { int in self.executed = true }
        }

        let fn: (Int) throws -> Void = weakify(object, f)
        object = nil
        try fn(123)

        XCTAssertFalse(executed)
    }

    func testUThrowsToVoid_WillNotExecuteIfNil() throws {
        func f(o object: Thing, i: Int) throws -> Void {
            self.executed = true
        }

        let fn = weakify(object, f)
        object = nil
        try fn(123)

        XCTAssertFalse(executed)
    }

    func testUThrowsToVoid_PartiallyApplied_WillThrowIfNotNil() {
        func f(o object: Thing) -> (Int) throws -> Void {
            return { _ in throw TestError() }
        }

        XCTAssertThrowsError(try weakify(object, f)(123))
    }

    func testUThrowsToVoid_WillThrowIfNotNil() {
        func f(o object: Thing, i: Int) throws -> Void {
            throw TestError()
        }

        XCTAssertThrowsError(try weakify(object, f)(123))
    }

    // MARK: - () -> U

    func testVoidToU_PartiallyApplied_WillExecuteIfNotNil() {
        func f(o object: Thing) -> () -> Int {
            return { return 123 }
        }

        let fn: () -> Int? = weakify(object, f)

        XCTAssertEqual(123, fn())
    }

    func testVoidToU_WillExecuteIfNotNil() {
        func f(o object: Thing) -> Int {
            return 123
        }
        let fn: () -> Int? = weakify(object, f)
        XCTAssertEqual(123, fn())
    }

    func testVoidThrowsToU_PartiallyApplied_WillExecuteIfNotNil() throws {
        func f(o object: Thing) -> () throws -> Int {
            return { return 123 }
        }

        let fn: () throws -> Int? = weakify(object, f)

        XCTAssertEqual(123, try fn())
    }

    func testVoidThrowsToU_WillExecuteIfNotNil() throws {
        func f(o object: Thing) throws -> Int {
            return 123
        }

        XCTAssertEqual(123, try weakify(object, f)())
    }

    func testVoidToU_PartiallyApplied_WillNotExecuteIfNil() {
        func f(o object: Thing) -> () -> Int {
            return { return 123 }
        }

        let fn = weakify(object, f)
        object = nil
        XCTAssertNil(fn())
    }

    func testVoidToU_WillNotExecuteIfNil() {
        func f(o object: Thing) -> Int {
            return 123
        }

        let fn = weakify(object, f)
        object = nil
        XCTAssertNil(fn())
    }

    func testVoidThrowsToU_PartiallyApplied_WillNotExecuteIfNil() throws {
        func f(o object: Thing) -> () throws -> Int {
            return { return 123 }
        }

        let fn: () throws -> Int? = weakify(object, f)
        object = nil
        XCTAssertNil(try fn())
    }

    func testVoidThrowsToU_WillNotExecuteIfNil() throws {
        func f(o object: Thing) throws -> Int {
            return 123
        }

        let fn: () throws -> Int? = weakify(object, f)
        object = nil
        XCTAssertNil(try fn())
    }

    func testVoidThrowsToU_PartiallyApplied_WillThrowIfNotNil() {
        func f(o object: Thing) -> () throws -> Int {
            return { throw TestError() }
        }

        let fn: () throws -> Int? = weakify(object, f)

        XCTAssertThrowsError(try fn())
    }

    func testVoidThrowsToU_WillThrowIfNotNil() {
        func f(o object: Thing) throws -> Int {
            throw TestError()
        }

        let fn: () throws -> Int? = weakify(object, f)

        XCTAssertThrowsError(try fn())
    }

    // MARK: - U -> V

    func testUToV_PartiallyApplied_WillExecuteIfNotNil() {
        func f(o object: Thing) -> (Int) -> String {
            return { int in return String(int) }
        }

        XCTAssertEqual("123", weakify(object, f)(123))
    }

    func testUToV_WillExecuteIfNotNil() {
        func f(o object: Thing, int: Int) -> String {
            return String(int)
        }

        XCTAssertEqual("123", weakify(object, f)(123))
    }

    func testUThrowsToV_PartiallyApplied_WillExecuteIfNotNil() throws {
        func f(o object: Thing) -> (Int) throws -> String {
            return { int in return String(int) }
        }

        XCTAssertEqual("123", try weakify(object, f)(123))
    }

    func testUThrowsToV_WillExecuteIfNotNil() throws {
        func f(o object: Thing, int: Int) throws -> String {
            return String(int)
        }

        XCTAssertEqual("123", try weakify(object, f)(123))
    }

    func testUToV_PartiallyApplied_WillNotExecuteIfNil() {
        func f(o object: Thing) -> (Int) -> String {
            return { int in return String(int) }
        }

        let fn: (Int) -> String? = weakify(object, f)
        object = nil
        XCTAssertNil(fn(123))
    }

    func testUToV_WillNotExecuteIfNil() {
        func f(o object: Thing, int: Int) -> String {
            return String(int)
        }

        let fn: (Int) -> String? = weakify(object, f)
        object = nil
        XCTAssertNil(fn(123))
    }

    func testUThrowsToV_PartiallyApplied_WillNotExecuteIfNil() throws {
        func f(o object: Thing) -> (Int) throws -> String {
            return { int in return String(int) }
        }

        let fn: (Int) throws -> String? = weakify(object, f)
        object = nil
        XCTAssertNil(try fn(123))
    }

    func testUThrowsToV_WillNotExecuteIfNil() throws {
        func f(o object: Thing, int: Int) throws -> String {
            return String(int)
        }

        let fn: (Int) throws -> String? = weakify(object, f)
        object = nil
        XCTAssertNil(try fn(123))
    }

    func testUThrowsToV_PartiallyApplied_WillThrowIfNotNil() {
        func f(o object: Thing) -> (Int) throws -> String {
            return { _ in throw TestError() }
        }

        XCTAssertThrowsError(try weakify(object, f)(123))
    }

    func testUThrowsToV_WillThrowIfNotNil() {
        func f(o object: Thing, int: Int) throws -> String {
            throw TestError()
        }

        XCTAssertThrowsError(try weakify(object, f)(123))
    }

    // MARK: - U as? V -> Void

    var value: Int?

    func testUasV_PartiallyApplied_WillExecuteIfNotNil() {
        func f(o object: Thing) -> (Int?) -> Void {
            return { int in self.value = int; self.executed = true }
        }

        let fn: (Any) -> Void = weakify(object, f)
        fn(123)

        XCTAssertTrue(executed)
        XCTAssertEqual(123, value)
    }

    func testUasV_WillExecuteIfNotNil() {
        func f(o object: Thing, int: Int?) -> Void {
            self.value = int; self.executed = true
        }

        let fn: (Any) -> Void = weakify(object, f)
        fn(123)

        XCTAssertTrue(executed)
        XCTAssertEqual(123, value)
    }

    func testUasVThrows_PartiallyApplied_WillExecuteIfNotNil() {
        func f(o object: Thing) -> (Int?) throws -> Void {
            return { int in self.value = int; self.executed = true }
        }

        let fn: (Any) throws -> Void = weakify(object, f)
        try! fn(123)

        XCTAssertTrue(executed)
        XCTAssertEqual(123, value)
    }

    func testUasVThrows_WillExecuteIfNotNil() {
        func f(o object: Thing, int: Int?) throws -> Void {
            self.value = int; self.executed = true
        }

        let fn: (Any) throws -> Void = weakify(object, f)
        try! fn(123)

        XCTAssertTrue(executed)
        XCTAssertEqual(123, value)
    }

    func testUasV_PartiallyApplied_WillGetNilIfParameterCannotBeCastAsU() {
        func f(o object: Thing) -> (Int?) -> Void {
            return { int in self.value = int; self.executed = true }
        }

        weakify(object, f)("123")

        XCTAssertTrue(executed)
        XCTAssertEqual(nil, value)
    }

    func testUasV_WillGetNilIfParameterCannotBeCastAsU() {
        func f(o object: Thing, int: Int?) -> Void {
            self.value = int; self.executed = true
        }

        weakify(object, f)("123")

        XCTAssertTrue(executed)
        XCTAssertEqual(nil, value)
    }

    func testUasVThrows_PartiallyApplied_WillGetNilIfParameterCannotBeCastAsU() throws {
        func f(o object: Thing) -> (Int?) throws -> Void {
            return { int in self.value = int; self.executed = true }
        }

        try weakify(object, f)("123")

        XCTAssertTrue(executed)
        XCTAssertEqual(nil, value)
    }

    func testUasVThrows_WillGetNilIfParameterCannotBeCastAsU() throws {
        func f(o object: Thing, int: Int?) throws -> Void {
            self.value = int; self.executed = true
        }

        try weakify(object, f)("123")

        XCTAssertTrue(executed)
        XCTAssertEqual(nil, value)
    }

    func testUasV_PartiallyApplied_WillNotExecuteIfNil() {
        func f(o object: Thing) -> (Int?) -> Void {
            return { int in self.value = int; self.executed = true }
        }

        let fn: (Any) -> Void = weakify(object, f)
        object = nil
        fn("123")

        XCTAssertFalse(executed)
        XCTAssertEqual(nil, value)
    }

    func testUasV_WillNotExecuteIfNil() {
        func f(o object: Thing, int: Int?) -> Void {
            self.value = int; self.executed = true
        }

        let fn: (Any) -> Void = weakify(object, f)
        object = nil
        fn("123")

        XCTAssertFalse(executed)
        XCTAssertEqual(nil, value)
    }

    func testUasVThrows_PartiallyApplied_WillNotExecuteIfNil() {
        func f(o object: Thing) -> (Int?) throws -> Void {
            return { int in self.value = int; self.executed = true }
        }

        let fn: (Any) throws -> Void = weakify(object, f)
        object = nil
        try! fn("123")

        XCTAssertFalse(executed)
        XCTAssertEqual(nil, value)
    }

    func testUasVThrows_WillNotExecuteIfNil() {
        func f(o object: Thing, int: Int?) throws -> Void {
            self.value = int; self.executed = true
        }

        let fn: (Any) throws -> Void = weakify(object, f)
        object = nil
        try! fn("123")

        XCTAssertFalse(executed)
        XCTAssertEqual(nil, value)
    }

    func testUasVThrows_PartiallyApplied_WillThrowIfNotNil() {
        func f(o object: Thing) -> (Int?) throws -> Void {
            return { _ in throw TestError() }
        }

        XCTAssertThrowsError(try weakify(object, f)("123"))
    }

    func testUasVThrows_WillThrowIfNotNil() {
        func f(o object: Thing, int: Int?) throws -> Void {
            throw TestError()
        }

        XCTAssertThrowsError(try weakify(object, f)("123"))
    }
}
