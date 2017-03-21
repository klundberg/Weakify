# Weakify

[![CI Status](http://img.shields.io/travis/klundberg/Weakify.svg?style=flat)](https://travis-ci.org/klundberg/Weakify)
[![Version](https://img.shields.io/cocoapods/v/Weakify.svg?style=flat)](http://cocoapods.org/pods/Weakify)
[![codecov.io](https://img.shields.io/codecov/c/github/klundberg/Weakify.svg)](http://codecov.io/github/klundberg/Weakify)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/Weakify.svg?style=flat)](http://cocoapods.org/pods/Weakify)
[![Platform](https://img.shields.io/cocoapods/p/Weakify.svg?style=flat)](http://cocoapods.org/pods/Weakify)

## How it works

Weakify is a µframework providing some commonly useful variations of the `weakify()` function. `weakify()` is primarily a way to be able to use a method on a class as a "closure" value that would be managed by some other component, but in a way that prevents memory leaks from occurring.

If you were to define a (admittedly contrived) class like this:

```swift
class Thing {
    func doSomething() {
        print("Something!")
    }

    var callback: () -> Void = {}

    func registerCallback() {
        callback = self.doSomething
    }
}

let thing = Thing()
thing.registerCallback()
```

You would be creating a retain cycle, and `thing` would never be deallocated. Whenever you reference a method on an object without calling it, the instance of the class that the method is bound to is captured by the method for the lifetime of the method reference. This is because in Swift instance methods are effectively curried functions: the actual methods you write on classes and instances close over references to self (strongly) so that those references are guaranteed to live for the lifetime of the method.

You can get around this by doing the following in the registerCallback method:

```swift
func registerCallback() {
	callback = { [weak self] in
		self?.doSomething()
	}
}
```

which breaks the retain cycle. However, having to create a new closure whenever you want to do this is a little bit cumbersome if the method you're calling has the same signature, which is where `weakify()` comes in. Using it, you can rewrite this method like so:

```swift
func registerCallback() {
	callback = weakify(self, type(of: self).doSomething)
}
```

`weakify()` separates the instance of the object from the method using static method references (you can reference the `doSomething` method statically with `Thing.doSomething` or `type(of: self).doSomething`, which has a type of `(Thing) -> () -> ()`). In this example `weakify` weakly applies self to the curried function's first argument, returning a closure that has the type `() -> ()` which, when called, will execute the doSomething method *only if `self` has not been deallocated* (much like the manual closure that weakly captures self defined earlier).

## Usage

There are a few variants of weakify available in this library for you to use:

```swift
func weakify <T: AnyObject, U>(_ owner: T, _ f: (T) -> () -> ()) -> (U) -> ()
func weakify <T: AnyObject, U>(_ owner: T, _ f: (T) -> () throws ->()) -> (U) throws -> ()
```
may be applied to any method that takes no arguments and returns none. The resulting closure can accept an argument which will simply be ignored (useful in cases like `NSNotificationCenter` when you don't care about the `notification` argument), or the type may also represent `Void`, meaning no input arguments are necessary.

```swift
func weakify <T: AnyObject, U>(_ owner: T, _ f: (T) -> (U) -> ()) -> (U) -> ()
func weakify <T: AnyObject, U>(_ owner: T, _ f: (T) -> (U) throws ->()) -> (U) throws -> ()
```
may be applied to a method that accepts an argument and returns none, which the resulting closure mirrors.

```swift
func weakify <T: AnyObject, U, V>(_ owner: T, _ f: (T) -> (U) -> V) -> (U) -> V?
func weakify <T: AnyObject, U, V>(_ owner: T, _ f: (T) -> (U) throws -> V) -> (U) throws -> V?
```
may be applied to a function that accepts and returns something; effectively a union of the two previous cases.

```swift
func weakify <T: AnyObject, U, V>(_ owner: T, _ f: (T) -> (U?) -> ()) -> (V) -> ()
func weakify <T: AnyObject, U, V>(_ owner: T, _ f: (T) -> (U?) throws -> ()) -> (V) throws -> ()
```
may be applied to a function that accepts an optional value. The resulting closure can have a completely different type for the input argument. If `owner` is not `nil` at call time, the argument to the resulting closure is conditionally cast from `V` to `U` with the `as?` operator, and the result of that is passed to the original function (which is why it must accept an optional, in case the cast fails).

## Requirements

* 0.4.0 is supported on Xcode 8/Swift 3
* 0.3.0 is supported on Xcode 8/Swift 3, or on Xcode 7.3/Swift 2.2+
* 0.2.3 is supported on Xcode 8/Swift 2.3, or on Xcode 7/Swift 2.x
* 0.1.3 is supported on Xcode 6.3+/Swift 1.2
* iOS 8+/OS X 10.9+/watchOS 2+/tvOS 9+

## Installation

### CocoaPods

Weakify is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
# Swift 3.x:
pod "Weakify", "~> 0.4.0"

# Swift 2.x:
pod "Weakify", "~> 0.2.3"

# Swift 1.2:
pod "Weakify", "~> 0.1.3"
```

### Carthage

Weakify can be integrated with [Carthage](https://github.com/Carthage/Carthage). Add the following to your Cartfile to use it:

```
# Swift 3:
github "klundberg/Weakify" ~> 0.4.0

# Swift 2:
github "klundberg/Weakify" ~> 0.2.3

# Swift 1.2:
github "klundberg/Weakify" ~> 0.1.3
```

### Swift Package Manager

Add the following line to your dependencies list in your `Package.swift` file (altering the version as appropriate for your target swift version):

```
.Package(url: "https://github.com/klundberg/weakify.git", versions:Version(0,4,0)..<Version(0,5,0)),
```

### Manual installation

If you cannot use CocoaPods (e.g. if you still need to target iOS 7 at a minimum for instance), the recommended way to install this is to simply manually copy weakify.swift from the repo into your project. You may also opt to reference this repo as a git submodule, which is an exercise I leave to you.

## Author

Kevin Lundberg, kevin at klundberg dot com

## Contributions
If you have additional variants of Weakify you'd like to see, feel free to submit a pull request! Please include unit tests with any changes.

## License

Weakify is available under the MIT license. See the LICENSE file for more info.
