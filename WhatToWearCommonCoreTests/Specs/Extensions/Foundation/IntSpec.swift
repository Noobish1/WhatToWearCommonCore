import Quick
import Nimble
@testable import WhatToWearCommonCore

internal final class IntSpec: QuickSpec {
    internal override func spec() {
        describe("Int") {
            describe("its random") {
                var first: Int!
                var second: Int!
                
                beforeEach {
                    first = Int.wtw.random()
                    second = Int.wtw.random()
                }
                
                it("should return a random int") {
                    expect(first) != second
                }
            }
        }
    }
}
