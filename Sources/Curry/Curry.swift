//
//  Curry.swift
//
//  Created by Sean Langhi on 7/3/17.
//

// MARK: - Operators

precedencegroup CurryingPrecedence {
    higherThan: AssignmentPrecedence
    associativity: left
}

infix operator ^^ : CurryingPrecedence

// MARK: - Functions

// Takes a ternary function.  Returns a "closure factory".
// The factory accepts a constant argument, and returns a binary closure that will run the original ternary function with the constant argument in position 1, and the two closure parameters in positions 2 and 3.
public func curry<A, B, C, D>(_ ternaryFunc: @escaping (A, B, C) -> D )
->
(A) -> ((B, C) -> D) {
    return { a in { b, c in ternaryFunc(a, b, c) } }
}

// Fixes the first argument of a ternary function, yielding a binary function.
public func ^^ <A, B, C, D>(ternaryFunc: @escaping (A, B, C) -> D, arg: A)
->
(B, C) -> D {
    curry(ternaryFunc)(arg)
}

// Fixes all arguments of a ternary function, yielding a zero-arity function.
public func ^^ <A, B, C, D>(ternaryFunc: @escaping (A, B, C) -> D, args: (A, B, C))
->
() -> D {
    return { ternaryFunc(args.0, args.1, args.2) }
}

// Takes a binary function.  Returns a "closure factory".
// The factory accepts a constant LHS, and returns a unary closure that will run the original binary function with the constant LHS and a parameterized RHS.
public func curry<A, B, C>(_ binaryFunc: @escaping (A, B) -> C )
->
(A) -> ((B) -> C) {
    return { a in { b in binaryFunc(a, b) } }
}

// Fixes the first argument of a binary function, yielding a unary function.
public func ^^ <A, B, C>(binaryFunc: @escaping (A, B) -> C, arg: A)
->
(B) -> C {
    curry(binaryFunc)(arg)
}

// Fixes both arguments of a binary function, yielding a zero-arity function.
public func ^^ <A, B, C>(binaryFunc: @escaping (A, B) -> C, args: (A, B))
->
() -> C {
    return { binaryFunc(args.0, args.1) }
}

// Takes a unary function.  Returns a "closure factory".
// The factory accepts a constant argument, and returns a zero-arity closure that will run the original unary function with the constant argument.
public func curry<A, B>(_ unaryFunc: @escaping (A) -> B )
->
(A) -> (() -> B) {
    return { a in { unaryFunc(a) } }
}

// Fixes the argument of a unary function, yielding a zero-arity function.
public func ^^ <A, B>(_ unaryFunc: @escaping (A) -> B, arg: A)
->
() -> B {
    return curry(unaryFunc)(arg)
}
