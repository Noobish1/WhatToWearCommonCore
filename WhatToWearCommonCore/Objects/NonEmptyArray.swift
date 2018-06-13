// From: https://github.com/khanlou/NonEmptyArray
import Foundation

// MARK: NonEmptyArray
public struct NonEmptyArray<Element> {
    // MARK: properties
    fileprivate var elements: [Element]
    
    // MARK: init
    public init(elements: Element...) {
        self.elements = elements
    }
    
    public init(firstElement: Element, rest: [Element]) {
        self.elements = [firstElement].byAppending(rest)
    }
    
    public init?(array: [Element]) {
        guard !array.isEmpty else {
            return nil
        }
        self.elements = array
    }
    
    // MARK: computed properties
    public var count: Int {
        return elements.count
    }
    
    public var first: Element {
        // swiftlint:disable force_unwrapping
        return elements.first!
        // swiftlint:enable force_unwrapping
    }
    
    public var last: Element {
        // swiftlint:disable force_unwrapping
        return elements.last!
        // swiftlint:enable force_unwrapping
    }
    
    public var isEmpty: Bool {
        return false
    }
    
    // MARK: insertion
    public mutating func insert<C: Collection>(contentsOf collection: C, at index: Index) where C.Iterator.Element == Element {
        elements.insert(contentsOf: collection, at: index)
    }
    
    public mutating func insert(_ newElement: Element, at index: Index) {
        elements.insert(newElement, at: index)
    }
    
    // MARK: appending
    public mutating func append(_ newElement: Element) {
        elements.append(newElement)
    }
    
    public func byAppending(_ newElement: Element) -> NonEmptyArray<Element> {
        var copy = self
        copy.append(newElement)
        return copy
    }

    // MARK: subscripting
    public subscript (safe index: Int) -> Element? {
        return elements[safe: index]
    }
    
    // MARK: helpers
    public func toArray() -> [Element] {
        return elements
    }
    
    public mutating func removeLastElementAndAddElementToStart(_ element: Element) {
        elements.insert(element, at: 0)
        elements.removeLast()
    }
    
    public mutating func removeFirstElementAndAddElementToEnd(_ element: Element) {
        elements.append(element)
        elements.removeFirst()
    }
    
    // MARK: mapping
    public func map<T>(_ transform: (Element) throws -> T) rethrows -> NonEmptyArray<T> {
        // swiftlint:disable force_unwrapping
        return NonEmptyArray<T>(array: try elements.map(transform))!
        // swiftlint:enable force_unwrapping
    }
    
    // MARK: min/max
    public func min(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Element {
        // swiftlint:disable force_unwrapping
        return try elements.min(by: areInIncreasingOrder)!
        // swiftlint:enable force_unwrapping
    }
    
    public func max(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Element {
        // swiftlint:disable force_unwrapping
        return try elements.max(by: areInIncreasingOrder)!
        // swiftlint:enable force_unwrapping
    }
    
    // MARK: reversing
    public func reversed() -> NonEmptyArray<Element> {
        // swiftlint:disable force_unwrapping
        return NonEmptyArray(array: elements.reversed())!
        // swiftlint:enable force_unwrapping
    }
}

// MARK: Element: Strideable, Element.Stride: SignedInteger
public extension NonEmptyArray where Element: Strideable, Element.Stride: SignedInteger {
    public init(range: CountableClosedRange<Element>) {
        self.elements = Array(range)
    }
}

// MARK: CustomStringConvertible
extension NonEmptyArray: CustomStringConvertible {
    public var description: String {
        return elements.description
    }
}

// MARK: CustomDebugStringConvertible
extension NonEmptyArray: CustomDebugStringConvertible {
    public var debugDescription: String {
        return elements.debugDescription
    }
}

// MARK: Collection
extension NonEmptyArray: Collection {
    public typealias Index = Int
    
    public var startIndex: Int {
        return 0
    }
    
    public var endIndex: Int {
        return count
    }
    
    public func index(after i: Int) -> Int {
        return i + 1
    }
}

// MARK: MutableCollection
extension NonEmptyArray: MutableCollection {
    public subscript(_ index: Int) -> Element {
        get {
            return elements[index]
        }
        set {
            elements[index] = newValue
        }
    }
}

// MARK: Comparable elements
extension NonEmptyArray where Element: Comparable {
    public func min() -> Element {
        // swiftlint:disable force_unwrapping
        return elements.min()!
        // swiftlint:enable force_unwrapping
    }
    
    public func max() -> Element {
        // swiftlint:disable force_unwrapping
        return elements.max()!
        // swiftlint:enable force_unwrapping
    }
    
    public func maxIndex() -> Int {
        let max = self.max()
        
        // swiftlint:disable force_unwrapping
        return self.index(of: max)!
        // swiftlint:enable force_unwrapping
    }
    
    public mutating func sort() {
        elements.sort()
    }
    
    public func sorted() -> NonEmptyArray<Element> {
        // swiftlint:disable force_unwrapping
        return NonEmptyArray(array: elements.sorted())!
        // swiftlint:enable force_unwrapping
    }
}

// MARK: Equatable
extension NonEmptyArray: Equatable where Element: Equatable {
    public static func == (lhs: NonEmptyArray<Element>, rhs: NonEmptyArray<Element>) -> Bool {
        return lhs.elements == rhs.elements
    }
}
