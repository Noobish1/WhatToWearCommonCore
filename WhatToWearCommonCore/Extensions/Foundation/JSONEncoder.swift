import Foundation

public extension JSONEncoder {
    public static func wtwEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        
        return encoder
    }
}
