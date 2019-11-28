import Quick
import Nimble

#if os(iOS)
    @testable import WhatToWearCommonCore
#elseif os(macOS)
    @testable import WhatToWearCommonCore_Mac
#endif

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
