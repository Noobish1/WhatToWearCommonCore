import Quick
import Nimble
import Fakery
@testable import WhatToWearCommonCore

internal final class StringRepresentableSpec: QuickSpec {
    internal override func spec() {
        describe("StringRepresentable") {
            var faker: Faker!
            
            beforeEach {
                faker = Faker()
            }
            
            describe("its stringRepresentation") {
                context("when we are a float") {
                    var float: Float!
                    
                    beforeEach {
                        float = faker.number.randomFloat()
                    }
                    
                    it("should return the float in string form") {
                        expect(float.stringRepresentation) == String(float)
                    }
                }
                
                context("when we are a double") {
                    var double: Double!
                    
                    beforeEach {
                        double = faker.number.randomDouble()
                    }
                    
                    it("should return the double in string form") {
                        expect(double.stringRepresentation) == String(double)
                    }
                }
                
                context("when we are a string") {
                    var string: String!
                    
                    beforeEach {
                        string = faker.lorem.characters()
                    }
                    
                    it("should return itself") {
                        expect(string.stringRepresentation) == string
                    }
                }
            }
        }
    }
}
