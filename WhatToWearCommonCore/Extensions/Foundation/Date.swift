import Foundation

// MARK: General
extension Date {
    public static var now: Date {
        return Date()
    }
}

// MARK: Random
extension Date {
    public enum wtw {
        public static func random() -> Date {
            return Date(timeIntervalSince1970: Double.random(in: 0..<Double.greatestFiniteMagnitude))
        }
    }
}
