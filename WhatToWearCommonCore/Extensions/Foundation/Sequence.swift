import Foundation

// MARK: General
public extension Sequence {
    public func all(_ predicate: (Element) -> Bool) -> Bool {
        for value in self {
            if !predicate(value) {
                return false
            }
        }
        
        return true
    }
    
    public func none(_ predicate: (Element) -> Bool) -> Bool {
        for value in self {
            if predicate(value) {
                return false
            }
        }
        
        return true
    }
    
    public func any(_ predicate: (Element) -> Bool) -> Bool {
        for value in self {
            if predicate(value) {
                return true
            }
        }
        
        return false
    }
}
