// From https://github.com/pointfreeco/swift-validated

/// A result type that accumulates multiple errors.
public enum Validated<Value, Error> {
    /// Wraps a value that has passed validation.
    case valid(Value)
    
    /// Collects a non-empty array of errors due to validation failure.
    case invalid(NonEmptyArray<Error>)
    
    /// Fail with a validation error.
    ///
    /// - Parameter error: A single validation error.
    /// - Returns: The error, wrapped in a validated value.
    public static func error(_ error: Error) -> Validated {
        return .invalid(NonEmptyArray(elements: error))
    }
    
    /// Returns true for valid values.
    public var isValid: Bool {
        switch self {
            case .valid:
                return true
            case .invalid:
                return false
        }
    }
    
    /// Returns a valid value (or `nil`, when invalid).
    public var value: Value? {
        switch self {
            case let .valid(value):
                return value
            case .invalid:
                return nil
        }
    }
    
    /// Returns a non-empty array of errors (or `nil`, when valid).
    public var errors: NonEmptyArray<Error>? {
        switch self {
            case .valid:
                return nil
            case let .invalid(errors):
                return errors
        }
    }
    
    /// Case analysis to produce the same type. "Folds" a validated value into some other value.
    ///
    /// - Parameters:
    ///   - ifValid: A function that transforms a valid value into some other value.
    ///   - ifInvalid: A function that transforms a non-empty array of errors into some other value.
    /// - Returns: The result of the transformation.
    public func validate<ValueOfResult>(
        ifValid: (Value) -> ValueOfResult,
        ifInvalid: (NonEmptyArray<Error>) -> ValueOfResult
    )
        -> ValueOfResult {
            switch self {
                case let .valid(value):
                    return ifValid(value)
                case let .invalid(errors):
                    return ifInvalid(errors)
            }
    }
    
    /// Transforms a valid value into some other valid value.
    ///
    /// - Parameter transform: A transform function for valid values.
    /// - Returns: A new validated value.
    public func map<ValueOfResult>(_ transform: (Value) -> ValueOfResult) -> Validated<ValueOfResult, Error> {
        switch self {
            case let .valid(value):
                return .valid(transform(value))
            case let .invalid(errors):
                return .invalid(errors)
        }
    }
}

extension Validated: Equatable where Value: Equatable, Error: Equatable {
    public static func == (lhs: Validated, rhs: Validated) -> Bool {
        switch (lhs, rhs) {
            case let (.valid(value1), .valid(value2)):
                return value1 == value2
            case let (.invalid(errors1), .invalid(errors2)):
                return errors1 == errors2
            case (.valid, .invalid), (.invalid, .valid):
                return false
        }
    }
}

/// Zips multiple validated values together, accumulating errors if both sides are invalid.
///
/// - Parameters:
///   - validated1: A validated value (or errors).
///   - validated2: A second, validated value (or errors).
/// - Returns: A validated tuple of the first and second value (or the accumulation of any errors).
public func zip<Value1, Value2, Error>(
    _ validated1: Validated<Value1, Error>,
    _ validated2: Validated<Value2, Error>
) -> Validated<(Value1, Value2), Error> {
    switch (validated1, validated2) {
        case let (.valid(value1), .valid(value2)):
            return .valid((value1, value2))
        case let (.valid, .invalid(errors)):
            return .invalid(errors)
        case let (.invalid(errors), .valid):
            return .invalid(errors)
        case let (.invalid(errors1), .invalid(errors2)):
            return .invalid(errors1.byAppending(contentsOf: errors2))
    }
}

/// Lifts a function that takes two values and returns a result into a function that takes two validated
/// values and returns a validated result.
///
/// - Parameter transform: A tranform function that takes two values and returns a result.
/// - Returns: A function that takes two validated values and returns a validated result.
public func zip<Value1, Value2, ValueOfResult, Error>(
    with transform: @escaping (Value1, Value2) -> ValueOfResult
) -> (Validated<Value1, Error>, Validated<Value2, Error>) -> Validated<ValueOfResult, Error> {
    return { zip($0, $1).map(transform) }
}

public func zip<A, B, C, Error>(
    _ a: Validated<A, Error>,
    _ b: Validated<B, Error>,
    _ c: Validated<C, Error>
)
    -> Validated<(A, B, C), Error> {
        return zip(zip(a, b), c)
            .map { ($0.0, $0.1, $1) }
}

public func zip<A, B, C, D, Error>(
    with f: @escaping (A, B, C) -> D
)
    -> (
    Validated<A, Error>,
    Validated<B, Error>,
    Validated<C, Error>
    )
    -> Validated<D, Error> {
        return { zip($0, $1, $2).map(f) }
}

public func zip<A, B, C, D, Error>(
    _ a: Validated<A, Error>,
    _ b: Validated<B, Error>,
    _ c: Validated<C, Error>,
    _ d: Validated<D, Error>
)
    -> Validated<(A, B, C, D), Error> {
        return zip(zip(a, b), c, d)
            .map { ($0.0, $0.1, $1, $2) }
}

public func zip<A, B, C, D, E, Error>(
    with f: @escaping (A, B, C, D) -> E
)
    -> (
    Validated<A, Error>,
    Validated<B, Error>,
    Validated<C, Error>,
    Validated<D, Error>
    )
    -> Validated<E, Error> {
        return { zip($0, $1, $2, $3).map(f) }
}

public func zip<A, B, C, D, E, Error>(
    _ a: Validated<A, Error>,
    _ b: Validated<B, Error>,
    _ c: Validated<C, Error>,
    _ d: Validated<D, Error>,
    _ e: Validated<E, Error>
)
    -> Validated<(A, B, C, D, E), Error> {
        return zip(zip(a, b), c, d, e)
            .map { ($0.0, $0.1, $1, $2, $3) }
}

public func zip<A, B, C, D, E, F, Error>(
    with f: @escaping (A, B, C, D, E) -> F
)
    -> (
    Validated<A, Error>,
    Validated<B, Error>,
    Validated<C, Error>,
    Validated<D, Error>,
    Validated<E, Error>
    )
    -> Validated<F, Error> {
        return { zip($0, $1, $2, $3, $4).map(f) }
}

public func zip<A, B, C, D, E, F, Error>(
    _ a: Validated<A, Error>,
    _ b: Validated<B, Error>,
    _ c: Validated<C, Error>,
    _ d: Validated<D, Error>,
    _ e: Validated<E, Error>,
    _ f: Validated<F, Error>
)
    -> Validated<(A, B, C, D, E, F), Error> {
        return zip(zip(a, b), c, d, e, f)
            .map { ($0.0, $0.1, $1, $2, $3, $4) }
}

public func zip<A, B, C, D, E, F, G, Error>(
    with f: @escaping (A, B, C, D, E, F) -> G
)
    -> (
    Validated<A, Error>,
    Validated<B, Error>,
    Validated<C, Error>,
    Validated<D, Error>,
    Validated<E, Error>,
    Validated<F, Error>
    )
    -> Validated<G, Error> {
        return { zip($0, $1, $2, $3, $4, $5).map(f) }
}

public func zip<A, B, C, D, E, F, G, Error>(
    _ a: Validated<A, Error>,
    _ b: Validated<B, Error>,
    _ c: Validated<C, Error>,
    _ d: Validated<D, Error>,
    _ e: Validated<E, Error>,
    _ f: Validated<F, Error>,
    _ g: Validated<G, Error>
)
    -> Validated<(A, B, C, D, E, F, G), Error> {
        return zip(zip(a, b), c, d, e, f, g)
            .map { ($0.0, $0.1, $1, $2, $3, $4, $5) }
}

public func zip<A, B, C, D, E, F, G, H, Error>(
    with f: @escaping (A, B, C, D, E, F, G) -> H
)
    -> (
    Validated<A, Error>,
    Validated<B, Error>,
    Validated<C, Error>,
    Validated<D, Error>,
    Validated<E, Error>,
    Validated<F, Error>,
    Validated<G, Error>
    )
    -> Validated<H, Error> {
        return { zip($0, $1, $2, $3, $4, $5, $6).map(f) }
}

public func zip<A, B, C, D, E, F, G, H, Error>(
    _ a: Validated<A, Error>,
    _ b: Validated<B, Error>,
    _ c: Validated<C, Error>,
    _ d: Validated<D, Error>,
    _ e: Validated<E, Error>,
    _ f: Validated<F, Error>,
    _ g: Validated<G, Error>,
    _ h: Validated<H, Error>
)
    -> Validated<(A, B, C, D, E, F, G, H), Error> {
        return zip(zip(a, b), c, d, e, f, g, h)
            .map { ($0.0, $0.1, $1, $2, $3, $4, $5, $6) }
}

public func zip<A, B, C, D, E, F, G, H, I, Error>(
    with f: @escaping (A, B, C, D, E, F, G, H) -> I
)
    -> (
    Validated<A, Error>,
    Validated<B, Error>,
    Validated<C, Error>,
    Validated<D, Error>,
    Validated<E, Error>,
    Validated<F, Error>,
    Validated<G, Error>,
    Validated<H, Error>
    )
    -> Validated<I, Error> {
        return { zip($0, $1, $2, $3, $4, $5, $6, $7).map(f) }
}

public func zip<A, B, C, D, E, F, G, H, I, Error>(
    _ a: Validated<A, Error>,
    _ b: Validated<B, Error>,
    _ c: Validated<C, Error>,
    _ d: Validated<D, Error>,
    _ e: Validated<E, Error>,
    _ f: Validated<F, Error>,
    _ g: Validated<G, Error>,
    _ h: Validated<H, Error>,
    _ i: Validated<I, Error>
)
    -> Validated<(A, B, C, D, E, F, G, H, I), Error> {
        return zip(zip(a, b), c, d, e, f, g, h, i)
            .map { ($0.0, $0.1, $1, $2, $3, $4, $5, $6, $7) }
}

public func zip<A, B, C, D, E, F, G, H, I, J, Error>(
    with f: @escaping (A, B, C, D, E, F, G, H, I) -> J
)
    -> (
    Validated<A, Error>,
    Validated<B, Error>,
    Validated<C, Error>,
    Validated<D, Error>,
    Validated<E, Error>,
    Validated<F, Error>,
    Validated<G, Error>,
    Validated<H, Error>,
    Validated<I, Error>
    )
    -> Validated<J, Error> {
        return { zip($0, $1, $2, $3, $4, $5, $6, $7, $8).map(f) }
}

public func zip<A, B, C, D, E, F, G, H, I, J, Error>(
    _ a: Validated<A, Error>,
    _ b: Validated<B, Error>,
    _ c: Validated<C, Error>,
    _ d: Validated<D, Error>,
    _ e: Validated<E, Error>,
    _ f: Validated<F, Error>,
    _ g: Validated<G, Error>,
    _ h: Validated<H, Error>,
    _ i: Validated<I, Error>,
    _ j: Validated<J, Error>
)
    -> Validated<(A, B, C, D, E, F, G, H, I, J), Error> {
        return zip(zip(a, b), c, d, e, f, g, h, i, j)
            .map { ($0.0, $0.1, $1, $2, $3, $4, $5, $6, $7, $8) }
}

public func zip<A, B, C, D, E, F, G, H, I, J, K, Error>(
    with f: @escaping (A, B, C, D, E, F, G, H, I, J) -> K
)
    -> (
    Validated<A, Error>,
    Validated<B, Error>,
    Validated<C, Error>,
    Validated<D, Error>,
    Validated<E, Error>,
    Validated<F, Error>,
    Validated<G, Error>,
    Validated<H, Error>,
    Validated<I, Error>,
    Validated<J, Error>
    )
    -> Validated<K, Error> {
        return { zip($0, $1, $2, $3, $4, $5, $6, $7, $8, $9).map(f) }
}

