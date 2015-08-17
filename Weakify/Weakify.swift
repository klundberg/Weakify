//
//  Weakify.swift
//  Weakify
//
//  Created by Kevin Lundberg on 8/16/15.
//  Copyright (c) 2015 Kevin Lundberg. All rights reserved.
//

// these functions take a swift class's statically referenced method and the instance those methods
// should apply to, and returns a function that weakly captures the instance so that you don't have
// to worry about memory retain cycles if you want to directly use an instance method as a handler
// for some object, like NSNotificationCenter.
//
// For more information, see this post:
// http://www.klundberg.com/blog/capturing-objects-weakly-in-instance-method-references-in-swift/


// this one can be used in cases where U is Void as well
public func weakify <T: AnyObject, U>(owner: T, f: T->()->()) -> U -> () {
    return { [weak owner] _ in
        if let this = owner {
            f(this)()
        }
    }
}

public func weakify <T: AnyObject, U>(owner: T, f: T->U->()) -> U -> () {
    return { [weak owner] obj in
        if let this = owner {
            f(this)(obj)
        }
    }
}

public func weakify <T: AnyObject, U>(owner: T, f: T->()->U) -> () -> U? {
    return { [weak owner] in
        if let this = owner {
            return f(this)()
        } else {
            return nil
        }
    }
}

public func weakify <T: AnyObject, U, V>(owner: T, f: T->U->V) -> U -> V? {
    return { [weak owner] obj in
        if let this = owner {
            return f(this)(obj)
        } else {
            return nil
        }
    }
}

public func weakify <T: AnyObject, U, V>(owner: T, f: T->U?->()) -> V -> () {
    return { [weak owner] obj in
        if let this = owner {
            f(this)(obj as? U)
        }
    }
}
