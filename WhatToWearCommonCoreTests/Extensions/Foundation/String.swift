import Foundation

internal extension String {
    internal enum wtw {
        internal static func random() -> String {
            return Array(repeating: (), count: .random(in: 0...280))
                .map { String(UnicodeScalar(UInt8.random(in: UInt8.min...UInt8.max))) }
                .joined()
        }
    }
}
