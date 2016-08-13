// https://github.com/Quick/Quick

import Quick
import Nimble
import Weakify

private class Thing {}
private enum Error: ErrorType { case Error }

class WeakifySpec: QuickSpec {
    override func spec() {
        var object: Thing?
        var executed = false

        beforeEach {
            executed = false
            object = Thing()
        }

        describe("weakify U as? V -> ()") {
            class Base {}
            class Child: Base {}

            var value: Child?

            context("normal version") {
                let function = { (object: Thing) -> Child? -> () in
                    return { executed = true; value = $0 }
                }

                var f: Base -> () = { _ in }

                beforeEach {
                    f = weakify(object!, function)
                }

                it("will execute the method with the expected value") {
                    let child = Child()
                    f(child) // child is upcast to Base in f, then successfully downcast back to Child
                    expect(executed) == true
                    expect(value) === child
                }

                it("will execute the method with a nil value when the parameter cannot be cast") {
                    f(Base()) // base cannot be successfully downcast to Child
                    expect(executed) == true
                    expect(value).to(beNil())
                }

                it("will not execute the method") {
                    object = nil
                    f(Child())
                    expect(executed) == false
                }
            }

            context("throwsing version") {
                let function = { (object: Thing) -> Child? throws -> () in
                    return { executed = true; value = $0 }
                }

                var f: Base throws -> () = { _ in }

                beforeEach {
                    f = weakify(object!, function)
                }

                it("will execute the method with the expected value") {
                    let child = Child()
                    try! f(child) // child is upcast to Base in f, then successfully downcast back to Child
                    expect(executed) == true
                    expect(value) === child
                }

                it("will execute the method with a nil value when the parameter cannot be cast") {
                    try! f(Base()) // base cannot be successfully downcast to Child
                    expect(executed) == true
                    expect(value).to(beNil())
                }

                it("will not execute the method") {
                    object = nil
                    try! f(Child())
                    expect(executed) == false
                }
            }

            context("throwsing version that throws") {
                let function = { (object: Thing) -> Child? throws -> () in
                    return { _ in throw Error.Error }
                }

                var f: Base throws -> () = { _ in }

                beforeEach {
                    f = weakify(object!, function)
                }

                it("will throw an error") {
                    do {
                        try f(Child())
                    } catch Error.Error {
                        // do nothing, success case
                    } catch {
                        fail("wrong error type thrown: \(error)")
                    }
                }
            }
        }
    }
}
