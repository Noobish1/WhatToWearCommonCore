import Foundation

public extension JSONDecoder {
    public static func wtwDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        return decoder
    }
}
