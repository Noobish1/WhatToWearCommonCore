import Foundation

public extension Float {
    // swiftlint:disable type_name
    public enum wtw {
    // swiftlint:enable type_name
        public static func random() -> Float {
            return Float.random(in: Float.leastNormalMagnitude...Float.greatestFiniteMagnitude)
        }
    }
}
