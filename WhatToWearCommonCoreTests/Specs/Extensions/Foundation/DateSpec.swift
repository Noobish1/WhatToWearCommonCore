import Quick
import Nimble

#if os(iOS)
    @testable import WhatToWearCommonCore
#elseif os(macOS)
    @testable import WhatToWearCommonCore_Mac
#endif

internal final class DateSpec: QuickSpec {
    internal override func spec() {
        describe("Date") {
            describe("its random") {
                var firstDate: Date!
                var secondDate: Date!
                
                beforeEach {
                    firstDate = Date.wtw.random()
                    secondDate = Date.wtw.random()
                }
                
                it("should return a random date") {
                    expect(firstDate) != secondDate
                }
            }
        }
    }
}
