import Foundation

// MARK: Equatable arrays
public extension Array where Element: Equatable {
    // MARK: replacing
    public func byReplacing(_ element: Element, with otherElement: Element) -> [Element] {
        var array = self
        array.replace(element, with: otherElement)
        
        return array
    }
    
    public mutating func replace(_ element: Element, with otherElement: Element) {
        guard let index = index(of: element) else { return }
        
        self[index] = otherElement
    }
    
    // MARK: removing
    public func byRemoving(_ element: Element) -> [Element] {
        var array = self
        array.remove(element)
        
        return array
    }
    
    public mutating func remove(_ element: Element) {
        guard let index = index(of: element) else { return }
        
        self.remove(at: index)
    }
}

// MARK: General extensions
public extension Array {
    // MARK: Removing multiple indices
    public func byRemoving(at indices: [Int]) -> [Element] {
        var array = self
        array.remove(at: indices)
        
        return array
    }
    
    public mutating func remove(at indices: [Int]) {
        let set = Set(self.indices).subtracting(indices)
        
        self = self.enumerated().filter { set.contains($0.offset) }.map { $0.element }
    }
    
    // MARK: safe subscripting
    public subscript (safe index: Int) -> Element? {
        return index < count ? self[index] : nil
    }

    // MARK: appending
    public func byAppending(_ element: Element) -> [Element] {
        var array = self
        array.append(element)
        
        return array
    }
    
    public func byAppending(_ elements: [Element]) -> [Element] {
        var array = self
        array.append(contentsOf: elements)
        
        return array
    }
    
    // MARK: grouping
    public func group<T>(by: (Element) -> T) -> [T: [Element]] {
        var clusters: [T: [Element]] = [:]
        
        forEach { element in
            let component = by(element)
            
            if !clusters.keys.contains(component) {
                clusters[component] = []
            }
            
            clusters[component]?.append(element)
        }
        
        return clusters
    }
}
