import Foundation

// All arrays
internal extension Array {
    internal func randomIndex() -> Int? {
        guard self.count > 0 else {
            return nil
        }
        
        return Int.random(in: 0...(self.count - 1))
    }
}

// Int arrays
internal extension Array where Element == Int {
    internal static func wtw_random(size: Int = Int.wtw.random()) -> [Element] {
        return Array<Void>(repeating: (), count: size).map { Int.wtw.random() }
    }
}

// String arrays
internal extension Array where Element == String {
    internal static func wtw_random(size: Int = Int.wtw.random()) -> [Element] {
        return Array<Void>(repeating: (), count: size).map { String.wtw.random() }
    }
}
