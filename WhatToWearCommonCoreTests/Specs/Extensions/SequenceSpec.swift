import Quick
import Nimble
import Fakery

internal final class SequenceSpec: QuickSpec {
    internal override func spec() {
        describe("Sequence") {
            describe("its all") {
                var sequence: [Int]!
                
                context("when one of the elements does not satisfy the predicate") {
                    beforeEach {
                        sequence = [1, 2, 3]
                    }
                    
                    it("should return false") {
                        expect(sequence.all { $0 > 1 }).to(beFalse())
                    }
                }
                
                context("when all of the elements satisfy the predicate") {
                    beforeEach {
                        sequence = [1, 2, 3]
                    }
                    
                    it("should return true") {
                        expect(sequence.all { $0 > 0 }).to(beTrue())
                    }
                }
            }
            
            describe("its none") {
                var sequence: [Int]!
                
                context("when one of the elements satisfies the predicate") {
                    beforeEach {
                        sequence = [1, 2, 3]
                    }
                    
                    it("should return false") {
                        expect(sequence.none { $0 == 2 }).to(beFalse())
                    }
                }
                
                context("when none of the elements satisfy the predicate") {
                    beforeEach {
                        sequence = [1, 2, 3]
                    }
                    
                    it("should return true") {
                        expect(sequence.none { $0 == 4 }).to(beTrue())
                    }
                }
            }
            
            describe("its any") {
                var sequence: [Int]!
                
                context("when any of the elements satisfy the predicate") {
                    beforeEach {
                        sequence = [1, 2, 3]
                    }
                    
                    it("should return true") {
                        expect(sequence.any { $0 == 1 }).to(beTrue())
                    }
                }
                
                context("when none of the elements satisfy the predicate") {
                    beforeEach {
                        sequence = [1, 2, 3]
                    }
                    
                    it("should return false") {
                        expect(sequence.any { $0 == 4}).to(beFalse())
                    }
                }
            }
        }
    }
}
