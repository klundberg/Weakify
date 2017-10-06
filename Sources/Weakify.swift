//  Copyright (c) 2015-2017 Kevin Lundberg. See LICENSE file for more info

// MARK: - (T) -> () -> ()
    
public func weakify <T: AnyObject>(_ owner: T, _ f: @escaping (T) -> () -> Void) -> () -> Void {
    return { [weak owner] in
        return owner.map { f($0)() }
    }
}

public func weakify <T: AnyObject>(_ owner: T, _ f: @escaping (T) -> () throws -> Void) -> () throws -> Void {
    return { [weak owner] in
        return try owner.map { try f($0)() }
    }
}

// MARK: - (T) -> ()

public func weakify <T: AnyObject>(_ owner: T, _ f: @escaping (T) -> Void) -> () -> Void {
    return { [weak owner] in
        return owner.map { f($0) }
    }
}

public func weakify <T: AnyObject>(_ owner: T, _ f: @escaping (T) throws -> Void) -> () throws -> Void {
    return { [weak owner] in
        return try owner.map { try f($0) }
    }
}

// MARK: - (T) -> (_) -> ()

/// May be applied to any method that takes no arguments and returns none. The resulting closure can accept an argument which will simply be ignored (useful in cases like `NSNotificationCenter` when you don't care about the `notification` argument), or the type may also represent `Void`, meaning no input arguments are necessary.
///
/// - Parameters:
///   - owner: The object to weakly apply to the given curried function or method
///   - f: The function/method to weakly apply owner to as the first argument
///
/// - returns: A function where owner is weakly applied to the given function f. If owner is nil, nothing happens. If owner is not nil, calls `f(owner)()`
public func weakify <T: AnyObject, U>(_ owner: T, _ f: @escaping (T) -> () -> Void) -> (U) -> Void {
    return { [weak owner] _ in
        return owner.map { f($0)() }
    }
}

/// May be applied to any method that takes no arguments and returns none or throws. The resulting closure can accept an argument which will simply be ignored (useful in cases like `NSNotificationCenter` when you don't care about the `notification` argument), or the type may also represent `Void`, meaning no input arguments are necessary.
///
/// - parameter owner: The object to weakly apply to the given curried function or method
/// - parameter f:     The function/method to weakly apply owner to as the first argument
///
/// - returns: A function where owner is weakly applied to the given function f. If owner is nil, nothing happens. If owner is not nil, calls `try f(owner)()`
public func weakify <T: AnyObject, U>(_ owner: T, _ f: @escaping (T) -> () throws -> Void) -> (U) throws -> Void {
    return { [weak owner] _ in
        return try owner.map { try f($0)() }
    }
}

// MARK: - (_) -> Void

public func weakify <T: AnyObject, U>(_ owner: T, _ f: @escaping (T) -> Void) -> (U) -> Void {
    return { [weak owner] _ in
        return owner.map { f($0) }
    }
}

public func weakify <T: AnyObject, U>(_ owner: T, _ f: @escaping (T) throws -> Void) -> (U) throws -> Void {
    return { [weak owner] _ in
        return try owner.map { try f($0) }
    }
}

// MARK: - (T) -> (U) -> ()

/// May be applied to a method that accepts an argument and returns none, which the resulting closure mirrors.
///
/// - parameter owner: The object to weakly apply to the given curried function or method
/// - parameter f:     The function/method to weakly apply owner to as the first argument
///
/// - returns: A function where owner is weakly applied to the given function f. If owner is nil, nothing happens. If owner is not nil, calls `f(owner)($0)`
public func weakify <T: AnyObject, U>(_ owner: T, _ f: @escaping (T) -> (U) -> Void) -> (U) -> Void {
    return { [weak owner] obj in
        return owner.map { f($0)(obj) }
    }
}

/// May be applied to a method that accepts an argument and returns none or throws, which the resulting closure mirrors.
///
/// - parameter owner: The object to weakly apply to the given curried function or method
/// - parameter f:     The function/method to weakly apply owner to as the first argument
///
/// - returns: A function where owner is weakly applied to the given function f. If owner is nil, nothing happens. If owner is not nil, calls `try f(owner)($0)`
public func weakify <T: AnyObject, U>(_ owner: T, _ f: @escaping (T) -> (U) throws -> Void) -> (U) throws -> Void {
    return { [weak owner] obj in
        return try owner.map { try f($0)(obj) }
    }
}

// MARK: - (T, U) -> ()

public func weakify <T: AnyObject, U>(_ owner: T, _ f: @escaping (T, U) -> Void) -> (U) -> Void {
    return weakify(owner, curry(f))
}

public func weakify <T: AnyObject, U>(_ owner: T, _ f: @escaping (T, U) throws -> Void) -> (U) throws -> Void {
    return weakify(owner, curry(f))
}

// MARK: - (T) -> () -> U

/// May be applied to a function that accepts and returns something. The resulting closure must return optional, since if owner is deallocated before it is called there's nothing else it can return.
///
/// - parameter owner: The object to weakly apply to the given curried function or method
/// - parameter f:     The function/method to weakly apply owner to as the first argument
///
/// - returns: A function where owner is weakly applied to the given function f. If owner is nil, returns nil. If owner is not nil, returns `f(owner)($0)`
public func weakify <T: AnyObject, U>(_ owner: T, _ f: @escaping (T) -> () -> U) -> () -> U? {
    return { [weak owner] in
        return owner.map { f($0)() }
    }
}

/// May be applied to a function that accepts and returns something or throws. The resulting closure must return optional, since if owner is deallocated before it is called there's nothing else it can return.
///
/// - parameter owner: The object to weakly apply to the given curried function or method
/// - parameter f:     The function/method to weakly apply owner to as the first argument
///
/// - returns: A function where owner is weakly applied to the given function f. If owner is nil, returns nil. If owner is not nil, returns `f(owner)($0)`
public func weakify <T: AnyObject, U>(_ owner: T, _ f: @escaping (T) -> () throws -> U) -> () throws -> U? {
    return { [weak owner] in
        return try owner.map { try f($0)() }
    }
}

// MARK: - (T) -> U

public func weakify <T: AnyObject, U>(_ owner: T, _ f: @escaping (T) -> U) -> () -> U? {
    return { [weak owner] in
        return owner.map { f($0) }
    }
}

public func weakify <T: AnyObject, U>(_ owner: T, _ f: @escaping (T) throws -> U) -> () throws -> U? {
    return { [weak owner] in
        return try owner.map { try f($0) }
    }
}

// MARK: - (T) -> (U) -> V

/// May be applied to a function that accepts and returns something. The resulting closure must return optional, since if owner is deallocated before it is called there's nothing else it can return.
///
/// - parameter owner: The object to weakly apply to the given curried function or method
/// - parameter f:     The function/method to weakly apply owner to as the first argument
///
/// - returns: A function where owner is weakly applied to the given function f. If owner is nil, returns nil. If owner is not nil, returns `f(owner)($0)`
public func weakify <T: AnyObject, U, V>(_ owner: T, _ f: @escaping (T) -> (U) -> V) -> (U) -> V? {
    return { [weak owner] obj in
        return owner.map { f($0)(obj) }
    }
}

/// May be applied to a function that accepts and returns something or throws. The resulting closure must return optional, since if owner is deallocated before it is called there's nothing else it can return.
///
/// - parameter owner: The object to weakly apply to the given curried function or method
/// - parameter f:     The function/method to weakly apply owner to as the first argument
///
/// - returns: A function where owner is weakly applied to the given function f. If owner is nil, returns nil. If owner is not nil, returns `f(owner)($0)`
public func weakify <T: AnyObject, U, V>(_ owner: T, _ f: @escaping (T) -> (U) throws -> V) -> (U) throws -> V? {
    return { [weak owner] obj in
        return try owner.map { try f($0)(obj) }
    }
}

// MARK -> (T, U) -> V

public func weakify <T: AnyObject, U, V>(_ owner: T, _ f: @escaping (T, U) -> V) -> (U) -> V? {
    return weakify(owner, curry(f))
}

public func weakify <T: AnyObject, U, V>(_ owner: T, _ f: @escaping (T, U) throws -> V) -> (U) throws -> V? {
    return weakify(owner, curry(f))
}

// MARK: - (T) -> (U?) -> ()

/// May be applied to a function that accepts an optional value. The resulting closure can have a completely different type for the input argument. If owner is not nil at call time, the argument to the resulting closure is conditionally cast from V to U with the as? operator, and the result of that is passed to the original function (which is why it must accept an optional, in case the cast fails).
///
/// - parameter owner: The object to weakly apply to the given curried function or method
/// - parameter f:     The function/method to weakly apply owner to as the first argument
///
/// - returns: A function where owner is weakly applied to the given function f. If owner is nil, nothing happens. If owner is not nil, returns `f(owner)($0 as? U)`
public func weakify <T: AnyObject, U, V>(_ owner: T, _ f: @escaping (T) -> (U?) -> Void) -> (V) -> Void {
    return { [weak owner] obj in
        return owner.map { f($0)(obj as? U) }
    }
}

/// May be applied to a function that accepts an optional value or throws. The resulting closure can have a completely different type for the input argument. If owner is not nil at call time, the argument to the resulting closure is conditionally cast from V to U with the as? operator, and the result of that is passed to the original function (which is why it must accept an optional, in case the cast fails).
///
/// - parameter owner: The object to weakly apply to the given curried function or method
/// - parameter f:     The function/method to weakly apply owner to as the first argument
///
/// - returns: A function where owner is weakly applied to the given function f. If owner is nil, nothing happens. If owner is not nil, returns `try f(owner)($0 as? U)`
public func weakify <T: AnyObject, U, V>(_ owner: T, _ f: @escaping (T) -> (U?) throws -> Void) -> (V) throws -> Void {
    return { [weak owner] obj in
        return try owner.map { try f($0)(obj as? U) }
    }
}

// MARK: - (T, U?) -> ()

public func weakify <T: AnyObject, U, V>(_ owner: T, _ f: @escaping (T, U?) -> Void) -> (V) -> Void {
    return weakify(owner, curry(f))
}

public func weakify <T: AnyObject, U, V>(_ owner: T, _ f: @escaping (T, U?) throws -> Void) -> (V) throws -> Void {
    return weakify(owner, curry(f))
}

// MARK: - Curry helper functions

private func curry <A,B,Result>(_ f: @escaping (A, B) -> Result) -> (A) -> (B) -> Result {
    return { a in { b in f(a,b) } }
}

private func curry <A,B,Result>(_ f: @escaping (A, B) throws -> Result) -> (A) -> (B) throws -> Result {
    return { a in { b in try f(a,b) } }
}
