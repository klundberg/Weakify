// https://github.com/Quick/Quick

import Quick
import Nimble
import Weakify

class Thing {}
enum Error: ErrorType { case Error }

func placeholder<T,U>(t:T) -> U { fatalError("placeholder function") }

class WeakifySpec: QuickSpec {
    override func spec() {
        var object: Thing?
        var executed = false

        beforeEach {
            executed = false
            object = Thing()
        }

        describe("weakify () -> ()") {
            context("normal version") {
                let function = { (object: Thing) -> () -> () in
                    return { executed = true }
                };
                var f: () -> () = placeholder

                beforeEach {
                    f = weakify(object!, function)
                }

                it("will execute the method") {
                    f()
                    expect(executed) == true
                }

                it("will not execute the method") {
                    object = nil
                    f()
                    expect(executed) == false
                }
            }

            context("throwsing version") {
                let function = { (object: Thing) -> () throws -> () in
                    return { executed = true }
                };
                var f: () throws -> () = placeholder

                beforeEach {
                    f = weakify(object!, function)
                }

                it("will execute the method") {
                    try! f()
                    expect(executed) == true
                }

                it("will not execute the method") {
                    object = nil
                    try! f()
                    expect(executed) == false
                }
            }

            context("throwsing version that throws") {
                let function = { (object: Thing) -> () throws -> () in
                    return { throw Error.Error }
                };
                var f: () throws -> () = placeholder

                beforeEach {
                    f = weakify(object!, function)
                }

                it("will throw an error") {
                    do {
                        try f()
                    } catch Error.Error {
                        // do nothing, success case
                    } catch {
                        fail("wrong error type thrown: \(error)")
                    }
                }
            }
        }

        describe("weakify U -> () ignoring U") {
            context("normal version") {
                let function = { (object: Thing) -> () -> () in
                    return { _ in executed = true }
                }

                var f: Int -> () = placeholder

                beforeEach {
                    f = weakify(object!, function)
                }

                it("will execute the method") {
                    f(123)
                    expect(executed) == true
                }

                it("will not execute the method") {
                    object = nil
                    f(123)
                    expect(executed) == false
                }
            }

            context("throwsing version") {
                let function = { (object: Thing) -> () throws -> () in
                    return { _ in executed = true }
                }

                var f: Int throws -> () = placeholder

                beforeEach {
                    f = weakify(object!, function)
                }

                it("will execute the method") {
                    try! f(123)
                    expect(executed) == true
                }

                it("will not execute the method") {
                    object = nil
                    try! f(123)
                    expect(executed) == false
                }
            }

            context("throwsing version that throws") {
                let function = { (object: Thing) -> () throws -> () in
                    return { _ in throw Error.Error }
                }

                var f: Int throws -> () = placeholder

                beforeEach {
                    f = weakify(object!, function)
                }

                it("will throw an error") {
                    do {
                        try f(123)
                    } catch Error.Error {
                        // do nothing, success case
                    } catch {
                        fail("wrong error type thrown: \(error)")
                    }
                }
            }
        }

        describe("weakify U -> ()") {
            var stringValue = "nil"
            context("normal version") {
                let function = { (object: Thing) -> (value: String) -> () in
                    return { stringValue = $0 }
                }
                var f: String -> () = placeholder

                beforeEach {
                    f = weakify(object!, function)
                    stringValue = "nil"
                }

                it("will execute the method with the expected parameter") {
                    f("non-nil")
                    expect(stringValue) == "non-nil"
                }

                it("will not execute the method") {
                    object = nil
                    f("non-nil")
                    expect(stringValue) == "nil"
                }
            }

            context("throwsing version") {
                let function = { (object: Thing) -> (value: String) throws -> () in
                    return { stringValue = $0 }
                }
                var f: String throws -> () = placeholder

                beforeEach {
                    f = weakify(object!, function)
                    stringValue = "nil"
                }

                it("will execute the method with the expected parameter") {
                    try! f("non-nil")
                    expect(stringValue) == "non-nil"
                }

                it("will not execute the method") {
                    object = nil
                    try! f("non-nil")
                    expect(stringValue) == "nil"
                }
            }
            context("throwsing version that throws") {
                let function = { (object: Thing) -> (value: String) throws -> () in
                    return { _ in throw Error.Error }
                }
                var f: String throws -> () = placeholder

                beforeEach {
                    f = weakify(object!, function)
                }

                it("will throw an error") {
                    do {
                        try f("anything")
                    } catch Error.Error {
                        // do nothing, success case
                    } catch {
                        fail("wrong error type thrown: \(error)")
                    }
                }
            }
        }

        describe("weakify () -> U") {
            context("normal version") {
                let function = { (object: Thing) -> () -> Int in
                    return { executed = true; return 123 }
                }
                var f: () -> Int? = placeholder

                beforeEach {
                    f = weakify(object!, function)
                }

                it("will execute the method and return an optional thing") {
                    expect(f()) == .Some(123)
                    expect(executed) == true;
                }

                it("will not execute and will return nil") {
                    object = nil
                    expect(f()).to(beNil())
                    expect(executed) == false
                }
            }

            context("throwsing version") {
                let function = { (object: Thing) -> () throws -> Int in
                    return { executed = true; return 123 }
                }
                var f: () throws -> Int? = placeholder

                beforeEach {
                    f = weakify(object!, function)
                }

                it("will execute the method and return an optional thing") {
                    expect(try! f()) == .Some(123)
                    expect(executed) == true;
                }

                it("will not execute and will return nil") {
                    object = nil
                    expect(try! f()).to(beNil())
                    expect(executed) == false
                }
            }

            context("throwsing version") {
                let function = { (object: Thing) -> () throws -> Int in
                    return { throw Error.Error }
                }
                var f: () throws -> Int? = placeholder

                beforeEach {
                    f = weakify(object!, function)
                }

                it("will throw an error") {
                    do {
                        try f()
                    } catch Error.Error {
                        // do nothing, success case
                    } catch {
                        fail("wrong error type thrown: \(error)")
                    }
                }
            }
        }

        describe("weakify U -> V") {
            context("normal version") {
                let function = { (object: Thing) -> Int -> String in
                    return { executed = true; return String($0) }
                }

                var f: Int -> String? = placeholder

                beforeEach {
                    f = weakify(object!, function)
                }

                it("will execute the method and return an optional thing") {
                    expect(f(123)) == .Some("123")
                    expect(executed) == true;
                }

                it("will not execute and will return nil") {
                    object = nil
                    expect(f(123)).to(beNil())
                    expect(executed) == false;
                }
            }

            context("throwsing version") {
                let function = { (object: Thing) -> Int throws -> String in
                    return { executed = true; return String($0) }
                }

                var f: Int throws -> String? = placeholder

                beforeEach {
                    f = weakify(object!, function)
                }

                it("will execute the method and return an optional thing") {
                    expect(try! f(123)) == .Some("123")
                    expect(executed) == true;
                }

                it("will not execute and will return nil") {
                    object = nil
                    expect(try! f(123)).to(beNil())
                    expect(executed) == false;
                }
            }

            context("throwsing version that throws") {
                let function = { (object: Thing) -> Int throws -> String in
                    return { _ in throw Error.Error }
                }

                var f: Int throws -> String? = placeholder

                beforeEach {
                    f = weakify(object!, function)
                }

                it("will throw an error") {
                    do {
                        try f(123)
                    } catch Error.Error {
                        // do nothing, success case
                    } catch {
                        fail("wrong error type thrown: \(error)")
                    }
                }
            }
        }

        describe("weakify U as? V -> ()") {
            class Base {}
            class Child: Base {}

            var value: Child?

            context("normal version") {
                let function = { (object: Thing) -> Child? -> () in
                    return { executed = true; value = $0 }
                }

                var f: Base -> () = placeholder

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

                var f: Base throws -> () = placeholder

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

                var f: Base throws -> () = placeholder

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
