// https://github.com/Quick/Quick

import Quick
import Nimble
import Weakify

class Thing {}

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

        describe("weakify U -> () throwing away U") {
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

        describe("weakify U -> ()") {
            var stringValue = "nil"
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

        describe("weakify () -> U") {
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

        describe("weakify U -> V") {
            let function = { (object: Thing) -> Int -> String in
                return { executed = true; return toString($0) }
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

        describe("weakify U as? V -> ()") {
            class Base {}
            class Child: Base {}

            var value: Child?

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
    }
}
