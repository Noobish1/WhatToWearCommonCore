import Quick
import Nimble
@testable import WhatToWearCommonCore

internal final class IntSpec: QuickSpec {
    internal override func spec() {
        describe("Int") {
            describe("its seconds") {
                var number: Int!
                
                beforeEach {
                    number = Int.wtw.random()
                }

                it("should return itself as a TimeInterval") {
                    expect(number.seconds) == TimeInterval(number)
                }
            }

            describe("its minutes") {
                var number: Int!
                
                beforeEach {
                    number = Int.wtw.random()
                }

                it("should return the same value as the TimeInterval function") {
                    expect(number.minutes) == TimeInterval(number).minutes
                }
            }

            describe("its hours") {
                var number: Int!
                
                beforeEach {
                    number = Int.wtw.random()
                }

                it("should return the same value as the TimeInterval function") {
                    expect(number.hours) == TimeInterval(number).hours
                }
            }

            describe("its days") {
                var number: Int!
                
                beforeEach {
                    number = Int.wtw.random()
                }

                it("should return the same value as the TimeInterval function") {
                    expect(number.days) == TimeInterval(number).days
                }
            }
            
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
