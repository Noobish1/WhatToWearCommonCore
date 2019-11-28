import Quick
import Nimble

#if os(iOS)
    @testable import WhatToWearCommonCore
#elseif os(macOS)
    @testable import WhatToWearCommonCore_Mac
#endif

internal final class ArraySpec: QuickSpec {
    internal override func spec() {
        describe("Array") {
            describe("its byReplacing element with otherElement") {
                var returnedArray: [String]!
                var replaceIndex: Int!
                var newElement: String!
                
                beforeEach {
                    let array = [String].wtw_random(size: Int.random(in: 3...8))
                    replaceIndex = array.randomIndex()!
                    let replaced = array[replaceIndex]
                    newElement = String.wtw.random()
                    
                    returnedArray = array.byReplacing(replaced, with: newElement)
                }
                
                it("should return an array with the given element replaced with the other given element") {
                    expect(returnedArray[replaceIndex]) == newElement
                }
            }
            
            describe("its replace element with otherElement") {
                var array: [String]!
                var replaceIndex: Int!
                var newElement: String!
                
                beforeEach {
                    array = [String].wtw_random(size: Int.random(in: 3...8))
                    replaceIndex = array.randomIndex()!
                    let replaced = array[replaceIndex]
                    newElement = String.wtw.random()
                    
                    array.replace(replaced, with: newElement)
                }
                
                it("should replace the given element with the other given element") {
                    expect(array[replaceIndex]) == newElement
                }
            }
            
            describe("its byRemoving element") {
                var returnedArray: [String]!
                var removedElement: String!
                
                beforeEach {
                    let array = [String].wtw_random(size: Int.random(in: 3...8))
                    let removeIndex = array.randomIndex()!
                    
                    removedElement = array[removeIndex]
                    returnedArray = array.byRemoving(removedElement)
                }
                
                it("should return an array with the given element removed") {
                    expect(returnedArray).toNot(contain(removedElement))
                }
            }
            
            describe("its remove element") {
                var array: [String]!
                var removedElement: String!
                
                beforeEach {
                    array = [String].wtw_random(size: Int.random(in: 3...8))
                    let removeIndex = array.randomIndex()!
                    
                    removedElement = array[removeIndex]
                    array.remove(removedElement)
                }
                
                it("should return an array with the given element removed") {
                    expect(array).toNot(contain(removedElement))
                }
            }
            
            describe("its byRemoving at indices") {
                var returnedArray: [String]!
                var removedElements: [String] = []
                
                beforeEach {
                    let array = [String].wtw_random(size: Int.random(in: 3...8))
                    
                    var removedIndices: [Int] = []
                    
                    for _ in 0...Int.random(in: 1...(array.count - 1)) {
                        removedIndices.append(array.randomIndex()!)
                    }
                    
                    for index in removedIndices {
                        removedElements.append(array[index])
                    }
                    
                    returnedArray = array.byRemoving(at: removedIndices)
                }
                
                it("should return an array with the elements at the given indices removed") {
                    expect(returnedArray).toNot(contain(removedElements))
                }
            }
            
            describe("its remove at indices") {
                var array: [String]!
                var removedElements: [String] = []
                
                beforeEach {
                    array = [String].wtw_random(size: Int.random(in: 3...8))
                    
                    var removedIndices: [Int] = []
                    
                    for _ in 0...Int.random(in: 1...(array.count - 1)) {
                        removedIndices.append(array.randomIndex()!)
                    }
                    
                    for index in removedIndices {
                        removedElements.append(array[index])
                    }
                    
                    array.remove(at: removedIndices)
                }
                
                it("should remove the elements at the given indices") {
                    expect(array).toNot(contain(removedElements))
                }
            }
            
            describe("its safe index") {
                var array: [String]!
                var index: Int!
                
                beforeEach {
                    array = [String].wtw_random(size: Int.random(in: 3...8))
                }
                
                context("when the given index is less than the array's count") {
                    beforeEach {
                        index = array.randomIndex()!
                    }
                    
                    it("should return the element at the given index") {
                        expect(array[safe: index]) == array[index]
                    }
                }
                
                context("when the given index is greater than or equal to the array's count") {
                    beforeEach {
                        index = array.count
                    }
                    
                    it("should return nil") {
                        expect(array[safe: index]).to(beNil())
                    }
                }
            }
            
            describe("its byAppending element") {
                var returnedArray: [String]!
                var newElement: String!
                
                beforeEach {
                    let array = [String].wtw_random(size: Int.random(in: 3...8))
                    
                    newElement = String.wtw.random()
                    returnedArray = array.byAppending(newElement)
                }
                
                it("should return an array with the given element appended") {
                    expect(returnedArray.last) == newElement
                }
            }
            
            describe("its byAppending elements") {
                var originalArray: [Int]!
                var returnedArray: [Int]!
                var newElements: [Int]!
                
                beforeEach {
                    let size = Int.random(in: 3...8)
                    originalArray = [Int].wtw_random(size: size)
                    
                    newElements = [Int].wtw_random(size: size)
                    returnedArray = originalArray.byAppending(newElements)
                }
                
                it("should return an array with the given elements appended") {
                    expect(Array(returnedArray.dropFirst(originalArray.count))) == newElements
                }
            }
            
            describe("its group by") {
                var array: [String]!
                var groups: [String : [String]]!
                var expectedGroups: [String : [String]]!
                
                beforeEach {
                    expectedGroups = [
                        "A" : ["Apple"],
                        "B" : ["Banana", "Blueberry"],
                        "P" : ["Pear", "Pineapple"],
                        "M" : ["Mandarin"]
                    ]
                    array = expectedGroups.values.flatMap { $0 }
                    groups = array.group(by: { String($0.first!) })
                }
                
                it("should return a dictionary with elements grouped by the returned property in the by closure") {
                    expect(groups) == expectedGroups
                }
            }
            
            describe("its randomIndex") {
                context("when the array is empty") {
                    var array: [Int]!
                    
                    beforeEach {
                        array = []
                    }
                    
                    it("should return nil") {
                        expect(array.randomIndex()).to(beNil())
                    }
                }
                
                context("when the array is not empty") {
                    var firstIndex: Int!
                    var secondIndex: Int!
                    
                    beforeEach {
                        let array = [Int].wtw_random(size: Int.random(in: 2...20))
                        
                        firstIndex = array.randomIndex()
                        secondIndex = array.randomIndex()
                    }
                    
                    it("should return a random index") {
                        expect(firstIndex) != secondIndex
                    }
                }
            }
            
            describe("its wtw_random") {
                var first: [Int]!
                var second: [Int]!
                
                beforeEach {
                    first = [Int].wtw_random()
                    second = [Int].wtw_random()
                }
                
                it("should return a random array") {
                    expect(first) != second
                }
            }
            
            describe("its randomSubArray") {
                var first: [Int]!
                var second: [Int]!
                
                context("when the array is empty") {
                    beforeEach {
                        let array: [Int] = []
                        
                        first = array.randomSubArray()
                        second = array.randomSubArray()
                    }
                    
                    it("should always return an empty array") {
                        expect(first).to(beEmpty())
                        expect(second).to(beEmpty())
                    }
                }
                
                context("when the array is not empty") {
                    beforeEach {
                        let array = [Int].wtw_random(size: Int.random(in: 5...20))
                        
                        first = array.randomSubArray()
                        second = array.randomSubArray()
                    }
                    
                    it("should return a random subarray") {
                        expect(first) != second
                    }
                }
            }
        }
    }
}
