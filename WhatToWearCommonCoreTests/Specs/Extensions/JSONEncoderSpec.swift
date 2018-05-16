import Quick
import Nimble
@testable import WhatToWearCommonCore

internal final class JSONEncoderSpec: QuickSpec {
    internal override func spec() {
        describe("JSONEncoder") {
            describe("its wtwEncoder") {
                var encoder: JSONEncoder!
                
                beforeEach {
                    encoder = JSONEncoder.wtwEncoder()
                }
                
                it("should return a JSONEncoder with the dateEncodingStrategy set to secondsSince1970") {
                    expect(
                        expression: {
                            switch encoder.dateEncodingStrategy {
                                case .secondsSince1970: return true
                                default: return false
                            }
                        }
                    ).to(beTrue())
                }
            }
        }
    }
}
