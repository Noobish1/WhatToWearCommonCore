import Foundation

// MARK: Int Extension for TimeInterval
extension Int {
    public var days: TimeInterval {
        return TimeInterval(self).days
    }

    public var hours: TimeInterval {
        return TimeInterval(self).hours
    }

    public var minutes: TimeInterval {
        return TimeInterval(self).minutes
    }

    public var seconds: TimeInterval {
        return TimeInterval(self)
    }
}

// MARK: WTWRandomized
extension Int: WTWRandomized {
    public enum wtw: WTWRandomizer {
        public static func random() -> Int {
            return Int.random(in: Int.min...Int.max)
        }
    }
}
