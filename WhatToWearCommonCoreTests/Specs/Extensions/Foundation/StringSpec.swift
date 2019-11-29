import Quick
import Nimble
@testable import WhatToWearCommonCore

internal final class StringSpec: QuickSpec {
    internal override func spec() {
        describe("String") {
            describe("its random") {
                var first: String!
                var second: String!
                
                beforeEach {
                    first = String.wtw.random()
                    second = String.wtw.random()
                }
                
                it("should return a random string") {
                    expect(first) != second
                }
            }
        }
    }
}
