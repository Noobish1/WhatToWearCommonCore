import Quick
import Nimble
@testable import WhatToWearCommonCore

internal final class DateSpec: QuickSpec {
    internal override func spec() {
        describe("Date") {
            describe("its now") {
                it("should return the current date") {
                    expect(Date.now).to(beCloseTo(Date()))
                }
            }
            
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
