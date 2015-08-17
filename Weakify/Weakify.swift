//
//  Weakify.swift
//  Weakify
//
//  Created by Kevin Lundberg on 8/16/15.
//  Copyright (c) 2015 Kevin Lundberg. All rights reserved.
//

/// May be applied to any method that takes no arguments and returns none. The resulting closure can accept an argument which will simply be ignored (useful in cases like `NSNotificationCenter` when you don't care about the `notification` argument), or the type may also represent `Void`, meaning no input arguments are necessary.

///
/// :param: owner The object to weakly apply to the given curried function or method
/// :param: f     The function/method to weakly apply owner to as the first argument
///
/// :returns: A function where owner is weakly applied to the given function f. If owner is nil, nothing happens. If owner is not nil, calls f(owner)()
public func weakify <T: AnyObject, U>(owner: T, f: T->()->()) -> U -> () {
    return { [weak owner] _ in
        if let this = owner {
            f(this)()
        }
    }
}

/// May be applied to a method that accepts an argument and returns none, which the resulting closure mirrors.
///
/// :param: owner The object to weakly apply to the given curried function or method
/// :param: f     The function/method to weakly apply owner to as the first argument
///
/// :returns: A function where owner is weakly applied to the given function f. If owner is nil, nothing happens. If owner is not nil, calls f(owner)($0)
public func weakify <T: AnyObject, U>(owner: T, f: T->U->()) -> U -> () {
    return { [weak owner] obj in
        if let this = owner {
            f(this)(obj)
        }
    }
}

/// May be applied to a function that returns some value. The resulting closure must return optional, since if owner is deallocated before it is called there's nothing else it can return.
///
/// :param: owner The object to weakly apply to the given curried function or method
/// :param: f     The function/method to weakly apply owner to as the first argument
///
/// :returns: A function where owner is weakly applied to the given function f. If owner is nil, returns nil. If owner is not nil, returns f(this)()
public func weakify <T: AnyObject, U>(owner: T, f: T->()->U) -> () -> U? {
    return { [weak owner] in
        if let this = owner {
            return f(this)()
        } else {
            return nil
        }
    }
}

/// May be applied to a function that accepts and returns something. The resulting closure must return optional, since if owner is deallocated before it is called there's nothing else it can return.
///
/// :param: owner The object to weakly apply to the given curried function or method
/// :param: f     The function/method to weakly apply owner to as the first argument
///
/// :returns: A function where owner is weakly applied to the given function f. If owner is nil, returns nil. If owner is not nil, returns f(this)($0)
public func weakify <T: AnyObject, U, V>(owner: T, f: T->U->V) -> U -> V? {
    return { [weak owner] obj in
        if let this = owner {
            return f(this)(obj)
        } else {
            return nil
        }
    }
}

/// May be applied to a function that accepts an optional value. The resulting closure can have a completely different type for the input argument. If owner is not nil at call time, the argument to the resulting closure is conditionally cast from V to U with the as? operator, and the result of that is passed to the original function (which is why it must accept an optional, in case the cast fails).
///
/// :param: owner The object to weakly apply to the given curried function or method
/// :param: f     The function/method to weakly apply owner to as the first argument
///
/// :returns: A function where owner is weakly applied to the given function f. If owner is nil, nothing happens. If owner is not nil, returns f(this)($0 as? U)
public func weakify <T: AnyObject, U, V>(owner: T, f: T->U?->()) -> V -> () {
    return { [weak owner] obj in
        if let this = owner {
            f(this)(obj as? U)
        }
    }
}
