import Foundation

public extension Float {
    public enum wtw {
        public static func random() -> Float {
            return Float.random(in: Float.leastNormalMagnitude...Float.greatestFiniteMagnitude)
        }
    }
}
