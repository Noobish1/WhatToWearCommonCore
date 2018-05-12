import Fakery
import WhatToWearCommonCore

internal extension Faker {
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
