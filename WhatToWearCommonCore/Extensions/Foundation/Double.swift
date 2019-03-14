import Foundation

public extension Double {
    public enum wtw {
        public static func random() -> Double {
            return Double.random(in: Double.leastNormalMagnitude...Double.greatestFiniteMagnitude)
        }
    }
}
