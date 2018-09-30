import Foundation

public extension Int {
    // swiftlint:disable type_name
    public enum wtw {
    // swiftlint:enable type_name
        public static func random() -> Int {
            return Int.random(in: Int.min...Int.max)
        }
    }
}
