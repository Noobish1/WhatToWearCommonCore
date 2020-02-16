// Originally based on: https://github.com/khanlou/NonEmptyArray
// Updated to be based on: https://github.com/pointfreeco/swift-nonempty
import Foundation

// MARK: NonEmptyArray
public struct NonEmptyArray<Element> {
    // MARK: DecodingError
    internal enum DecodingError: Error, Equatable {
        case emptyArray
    }
    
    // MARK: properties
    fileprivate var head: Element
    fileprivate var tail: [Element]

    // MARK: computed properties
    public var count: Int {
        return tail.count + 1
    }

    public var first: Element {
        return head
    }

    public var last: Element {
        if let nonEmptyTail = NonEmptyArray(array: tail) {
            return nonEmptyTail.last
        } else {
            return head
        }
    }

    public var isEmpty: Bool {
        return false
    }

    public var nonEmptyIndices: NonEmptyArray<Self.Index> {
        let array = Array(self.indices)

        // swiftlint:disable force_unwrapping
        return NonEmptyArray<Self.Index>(array: array)!
        // swiftlint:enable force_unwrapping
    }

    // MARK: init
    public init(elements: Element...) {
        self.head = elements[0] // This will always contain an element
        self.tail = Array(elements.dropFirst())
    }

    public init(firstElement: Element, rest: [Element]) {
        self.head = firstElement
        self.tail = rest
    }

    public init?(array: [Element]) {
        if array.isEmpty {
            return nil
        } else {
            self.head = array[0]
            self.tail = Array(array.dropFirst())
        }
    }

    // MARK: insertion
    public mutating func insert<C: Collection>(contentsOf collection: C, at index: Index) where C.Iterator.Element == Element {
        if index == 0 {
            var us = self.toArray()
            us.insert(contentsOf: collection, at: index)
            
            self.head = us[0]
            self.tail = Array(us.dropFirst())
        } else {
            tail.insert(contentsOf: collection, at: index - 1)
        }
    }

    public mutating func insert(_ newElement: Element, at index: Index) {
        if index == 0 {
            var us = self.toArray()
            us.insert(newElement, at: index)
            
            self.head = us[0]
            self.tail = Array(us.dropFirst())
        } else {
            tail.insert(newElement, at: index - 1)
        }
    }

    // MARK: appending
    public mutating func append(_ newElement: Element) {
        tail.append(newElement)
    }

    public func byAppending(_ newElement: Element) -> Self {
        var copy = self
        copy.append(newElement)
        return copy
    }

    // MARK: helpers
    public func toArray() -> [Element] {
        return [head].byAppending(tail)
    }

    public mutating func removeLastElementAndAddElementToStart(_ element: Element) {
        self.head = element
        self.tail = [head].byAppending(tail.dropLast())
    }

    public mutating func removeFirstElementAndAddElementToEnd(_ element: Element) {
        if let nonEmptyTail = NonEmptyArray(array: tail) {
            self.head = nonEmptyTail.first
            self.tail = Array(nonEmptyTail.dropFirst()).byAppending(element)
        } else {
            self.tail = [head]
            self.head = element
        }
    }

    // MARK: mapping
    public func map<T>(_ transform: (Element) throws -> T) rethrows -> NonEmptyArray<T> {
        // swiftlint:disable force_unwrapping
        return NonEmptyArray<T>(array: try self.toArray().map(transform))!
        // swiftlint:enable force_unwrapping
    }

    // MARK: min/max
    public func min(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Element {
        // swiftlint:disable force_unwrapping
        return try self.toArray().min(by: areInIncreasingOrder)!
        // swiftlint:enable force_unwrapping
    }

    public func max(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Element {
        // swiftlint:disable force_unwrapping
        return try self.toArray().max(by: areInIncreasingOrder)!
        // swiftlint:enable force_unwrapping
    }

    // MARK: reversing
    public func reversed() -> Self {
        // swiftlint:disable force_unwrapping
        return NonEmptyArray(array: self.toArray().reversed())!
        // swiftlint:enable force_unwrapping
    }

    // MARK: Random
    public func randomIndex() -> Int {
        return Int.random(in: 0...(self.count - 1))
    }

    public func randomElement() -> Element {
        let index = randomIndex()
        
        if index == 0 {
            return head
        } else {
            return tail[index - 1]
        }
    }

    public func randomSubArray() -> Self {
        let startIndex = Int.random(in: 0...(self.count - 1))
        let endIndex = Int.random(in: startIndex...(self.count - 1))

        // swiftlint:disable force_unwrapping
        return NonEmptyArray(array: Array(self[startIndex...endIndex]))!
        // swiftlint:enable force_unwrapping
    }

    // MARK: Sorting
    public func sorted(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Self {
        // swiftlint:disable force_unwrapping
        return try NonEmptyArray(array: self.toArray().sorted(by: areInIncreasingOrder))!
        // swiftlint:enable force_unwrapping
    }

    // MARK: subscripting
    public subscript (safe index: Int) -> Element? {
        if index == 0 {
            return head
        } else {
            return tail[safe: index - 1]
        }
    }
}

// MARK: Element: Strideable, Element.Stride: SignedInteger
extension NonEmptyArray where Element: Strideable, Element.Stride: SignedInteger {
    public init(range: CountableClosedRange<Element>) {
        let elements = Array(range)
        
        self.head = elements[0] // You can't have an empty range
        self.tail = Array(elements.dropFirst())
    }
}

// MARK: Element: Strideable
extension NonEmptyArray where Element: Strideable {
    public init(stride: StrideTo<Element>) {
        let elements = Array(stride)
        
        self.head = elements[0] // You can't have an empty stride
        self.tail = Array(elements.dropFirst())
    }

    public init(stride: StrideThrough<Element>) {
        let elements = Array(stride)
        
        self.head = elements[0] // You can't have an empty stride
        self.tail = Array(elements.dropFirst())
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
            if index == 0 {
                return head
            } else {
                return tail[index - 1]
            }
        }
        set {
            if index == 0 {
                head = newValue
            } else {
                tail[index - 1] = newValue
            }
        }
    }
}

// MARK: Equtable elements
extension NonEmptyArray where Element: Equatable {
    public mutating func replace(_ element: Element, with otherElement: Element) {
        if head == element {
            self.head = otherElement
        } else {
            tail.replace(element, with: otherElement)
        }
    }

    public func byReplacing(_ element: Element, with otherElement: Element) -> Self {
        var mutableSelf = self
        mutableSelf.replace(element, with: otherElement)

        return mutableSelf
    }
}

// MARK: Comparable elements
extension NonEmptyArray where Element: Comparable {
    public func min() -> Element {
        // swiftlint:disable force_unwrapping
        return self.toArray().min()!
        // swiftlint:enable force_unwrapping
    }

    public func max() -> Element {
        // swiftlint:disable force_unwrapping
        return self.toArray().max()!
        // swiftlint:enable force_unwrapping
    }

    public func maxIndex() -> Int {
        let max = self.max()

        // swiftlint:disable force_unwrapping
        return self.firstIndex(of: max)!
        // swiftlint:enable force_unwrapping
    }

    public mutating func sort() {
        let fullArray = self.toArray().sorted()
        
        self.head = fullArray[0]
        self.tail = Array(fullArray.dropFirst())
    }

    public func sorted() -> Self {
        let fullArray = self.toArray().sorted()
        
        return NonEmptyArray(firstElement: fullArray[0], rest: Array(fullArray.dropFirst()))
    }
}

// MARK: Equatable
extension NonEmptyArray: Equatable where Element: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.head == rhs.head && lhs.tail == rhs.tail
    }
}

// MARK: Codable
extension NonEmptyArray: Codable where Element: Codable {}

// MARK: NonEmptyArray's with WTWRandomized Elements
extension NonEmptyArray where Element: WTWRandomized {
    public static func wtw_random() -> Self {
        // We can't pass a size to this as we can't trust consumers to pass a number above 1
        let array = [Void](repeating: (), count: .random(in: 5...1000)).map { Element.wtw.random() }

        // swiftlint:disable force_unwrapping
        return NonEmptyArray(array: array)!
        // swiftlint:enable force_unwrapping
    }
}
