import Fakery
import WhatToWearCommonCore

internal extension Faker {
    // MARK: String arrays
    internal func randomStringArray(size: Int) -> [String] {
        var array: [String] = []
        
        for _ in 0...size {
            array.append(self.lorem.characters())
        }
        
        return array
    }
    
    internal func randomNonEmptyStringArray(size: Int) -> NonEmptyArray<String>? {
        return NonEmptyArray(
            array: self.randomStringArray(size: size)
        )
    }
    
    // MARK: Int arrays
    internal func randomIntArray(size: Int) -> [Int] {
        var array: [Int] = []
        
        for _ in 0...size {
            array.append(self.number.randomInt())
        }
        
        return array
    }
    
    internal func randomNonEmptyIntArray(size: Int) -> NonEmptyArray<Int>? {
        return NonEmptyArray(
            array: self.randomIntArray(size: size)
        )
    }
}
