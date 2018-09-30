import Foundation

public extension Date {
    // swiftlint:disable type_name
    public enum wtw {
        // swiftlint:enable type_name
        public static func random() -> Date {
            return Date(timeIntervalSince1970: Double.random(in: 0...Double.greatestFiniteMagnitude))
        }
    }
}
