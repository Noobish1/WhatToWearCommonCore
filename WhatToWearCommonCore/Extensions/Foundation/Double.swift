import Foundation

public extension Double {
    // swiftlint:disable type_name
    public enum wtw {
    // swiftlint:enable type_name
        public static func random() -> Double {
            return Double.random(in: Double.leastNormalMagnitude...Double.greatestFiniteMagnitude)
        }
    }
}
