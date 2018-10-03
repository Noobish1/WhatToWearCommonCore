import Foundation

public extension String {
    // swiftlint:disable type_name
    public enum wtw {
    // swiftlint:enable type_name
        public static func random() -> String {
            return Array(repeating: (), count: .random(in: 0...280))
                .map { String(UnicodeScalar(UInt8.random(in: UInt8.min...UInt8.max))) }
                .joined()
        }
    }
}
