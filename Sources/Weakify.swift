//
//  Weakify.swift
//  Weakify
//
//  Created by Kevin Lundberg on 8/16/15.
//  Copyright (c) 2015 Kevin Lundberg. All rights reserved.
//

/// May be applied to any method that takes no arguments and returns none. The resulting closure can accept an argument which will simply be ignored (useful in cases like `NSNotificationCenter` when you don't care about the `notification` argument), or the type may also represent `Void`, meaning no input arguments are necessary.
///
/// - parameter owner: The object to weakly apply to the given curried function or method
/// - parameter f:     The function/method to weakly apply owner to as the first argument
///
/// - returns: A function where owner is weakly applied to the given function f. If owner is nil, nothing happens. If owner is not nil, calls `f(owner)()`
public func weakify <T: AnyObject, U>(owner: T, _ f: (T) -> () -> Void) -> U -> Void {
    return { [weak owner] _ in
        if let this = owner {
            f(this)()
        }
    }
}

/// May be applied to any method that takes no arguments and returns none or throws. The resulting closure can accept an argument which will simply be ignored (useful in cases like `NSNotificationCenter` when you don't care about the `notification` argument), or the type may also represent `Void`, meaning no input arguments are necessary.
///
/// - parameter owner: The object to weakly apply to the given curried function or method
/// - parameter f:     The function/method to weakly apply owner to as the first argument
///
/// - returns: A function where owner is weakly applied to the given function f. If owner is nil, nothing happens. If owner is not nil, calls `try f(owner)()`
public func weakify <T: AnyObject, U>(owner: T, _ f: (T) -> () throws -> Void) -> U throws -> Void {
    return { [weak owner] _ in
        if let this = owner {
            try f(this)()
        }
    }
}

/// May be applied to a method that accepts an argument and returns none, which the resulting closure mirrors.
///
/// - parameter owner: The object to weakly apply to the given curried function or method
/// - parameter f:     The function/method to weakly apply owner to as the first argument
///
/// - returns: A function where owner is weakly applied to the given function f. If owner is nil, nothing happens. If owner is not nil, calls `f(owner)($0)`
public func weakify <T: AnyObject, U>(owner: T, _ f: (T) -> (U) -> Void) -> U -> Void {
    return { [weak owner] obj in
        if let this = owner {
            f(this)(obj)
        }
    }
}

/// May be applied to a method that accepts an argument and returns none or throws, which the resulting closure mirrors.
///
/// - parameter owner: The object to weakly apply to the given curried function or method
/// - parameter f:     The function/method to weakly apply owner to as the first argument
///
/// - returns: A function where owner is weakly applied to the given function f. If owner is nil, nothing happens. If owner is not nil, calls `try f(owner)($0)`
public func weakify <T: AnyObject, U>(owner: T, _ f: (T) -> (U) throws -> Void) -> (U) throws -> Void {
    return { [weak owner] obj in
        if let this = owner {
            try f(this)(obj)
        }
    }
}

/// May be applied to a function that accepts and returns something. The resulting closure must return optional, since if owner is deallocated before it is called there's nothing else it can return.
///
/// - parameter owner: The object to weakly apply to the given curried function or method
/// - parameter f:     The function/method to weakly apply owner to as the first argument
///
/// - returns: A function where owner is weakly applied to the given function f. If owner is nil, returns nil. If owner is not nil, returns `f(owner)($0)`
public func weakify <T: AnyObject, U, V>(owner: T, _ f: (T) -> (U) -> V) -> (U) -> V? {
    return { [weak owner] obj in
        if let this = owner {
            return f(this)(obj)
        } else {
            return nil
        }
    }
}

/// May be applied to a function that accepts and returns something or throws. The resulting closure must return optional, since if owner is deallocated before it is called there's nothing else it can return.
///
/// - parameter owner: The object to weakly apply to the given curried function or method
/// - parameter f:     The function/method to weakly apply owner to as the first argument
///
/// - returns: A function where owner is weakly applied to the given function f. If owner is nil, returns nil. If owner is not nil, returns `f(owner)($0)`
public func weakify <T: AnyObject, U, V>(owner: T, _ f: (T) -> (U) throws -> V) -> (U) throws -> V? {
    return { [weak owner] obj in
        if let this = owner {
            return try f(this)(obj)
        } else {
            return nil
        }
    }
}

/// May be applied to a function that accepts an optional value. The resulting closure can have a completely different type for the input argument. If owner is not nil at call time, the argument to the resulting closure is conditionally cast from V to U with the as? operator, and the result of that is passed to the original function (which is why it must accept an optional, in case the cast fails).
///
/// - parameter owner: The object to weakly apply to the given curried function or method
/// - parameter f:     The function/method to weakly apply owner to as the first argument
///
/// - returns: A function where owner is weakly applied to the given function f. If owner is nil, nothing happens. If owner is not nil, returns `f(owner)($0 as? U)`
public func weakify <T: AnyObject, U, V>(owner: T, _ f: (T) -> (U?) -> Void) -> (V) -> Void {
    return { [weak owner] obj in
        if let this = owner {
            f(this)(obj as? U)
        }
    }
}

/// May be applied to a function that accepts an optional value or throws. The resulting closure can have a completely different type for the input argument. If owner is not nil at call time, the argument to the resulting closure is conditionally cast from V to U with the as? operator, and the result of that is passed to the original function (which is why it must accept an optional, in case the cast fails).
///
/// - parameter owner: The object to weakly apply to the given curried function or method
/// - parameter f:     The function/method to weakly apply owner to as the first argument
///
/// - returns: A function where owner is weakly applied to the given function f. If owner is nil, nothing happens. If owner is not nil, returns `try f(owner)($0 as? U)`
public func weakify <T: AnyObject, U, V>(owner: T, _ f: (T) -> (U?) throws -> Void) -> (V) throws -> Void {
    return { [weak owner] obj in
        if let this = owner {
            try f(this)(obj as? U)
        }
    }
}
