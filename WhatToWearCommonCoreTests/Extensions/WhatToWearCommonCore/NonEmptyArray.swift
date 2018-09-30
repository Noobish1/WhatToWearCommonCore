import WhatToWearCommonCore

internal extension NonEmptyArray where Element == Int {
    internal static func wtw_random(size: Int = Int.random(in: 1...Int.max)) -> NonEmptyArray<Element>? {
        let array = [Int].wtw_random(size: size)
        
        return NonEmptyArray(array: array)
    }
}

internal extension NonEmptyArray where Element == String {
    internal static func wtw_random(size: Int = Int.random(in: 1...Int.max)) -> NonEmptyArray<Element>? {
        let array = [String].wtw_random(size: size)
        
        return NonEmptyArray(array: array)
    }
}
