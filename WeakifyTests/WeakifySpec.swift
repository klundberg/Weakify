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

        
    }
}
