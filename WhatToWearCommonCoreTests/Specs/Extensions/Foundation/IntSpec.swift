import Quick
import Nimble

#if os(iOS)
    @testable import WhatToWearCommonCore
#elseif os(macOS)
    @testable import WhatToWearCommonCore_Mac
#endif

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
