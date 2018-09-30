import Quick
import Nimble
@testable import WhatToWearCommonCore

internal final class StringRepresentableSpec: QuickSpec {
    internal override func spec() {
        describe("StringRepresentable") {            
            describe("its stringRepresentation") {
                context("when we are a float") {
                    var float: Float!
                    
                    beforeEach {
                        float = Float.wtw.random()
                    }
                    
                    it("should return the float in string form") {
                        expect(float.stringRepresentation) == String(float)
                    }
                }
                
                context("when we are a double") {
                    var double: Double!
                    
                    beforeEach {
                        double = Double.wtw.random()
                    }
                    
                    it("should return the double in string form") {
                        expect(double.stringRepresentation) == String(double)
                    }
                }
                
                context("when we are a string") {
                    var string: String!
                    
                    beforeEach {
                        string = String.wtw.random()
                    }
                    
                    it("should return itself") {
                        expect(string.stringRepresentation) == string
                    }
                }
            }
        }
    }
}
