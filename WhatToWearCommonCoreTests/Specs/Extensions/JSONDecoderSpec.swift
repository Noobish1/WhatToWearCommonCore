import Quick
import Nimble
@testable import WhatToWearCommonCore

internal final class JSONDecoderSpec: QuickSpec {
    internal override func spec() {
        describe("JSONEncoder") {
            describe("its wtwEncoder") {
                var decoder: JSONDecoder!
                
                beforeEach {
                    decoder = JSONDecoder.wtwDecoder()
                }
                
                it("should return a JSONEncoder with the dateEncodingStrategy set to secondsSince1970") {
                    expect(
                        expression: {
                            switch decoder.dateDecodingStrategy {
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
