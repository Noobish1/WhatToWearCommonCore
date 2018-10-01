import Quick
import Nimble
@testable import WhatToWearCommonCore

internal final class NonEmptyArraySpec: QuickSpec {
    internal override func spec() {
        describe("NonEmptyArray") {
            describe("its init with elements") {
                var firstElement: Int!
                var secondElement: Int!
                var array: NonEmptyArray<Int>!
                
                beforeEach {
                    firstElement = Int.random(in: Int.min...Int.max)
                    secondElement = Int.wtw.random()
                    array = NonEmptyArray(elements: firstElement, secondElement)
                }
                
                it("should create a NonEmptyArray with the given elements") {
                    expect(array[0]) == firstElement
                    expect(array[1]) == secondElement
                }
            }
            
            describe("its init with firstElement and rest") {
                var firstElement: Int!
                var rest: [Int]!
                var array: NonEmptyArray<Int>!
                
                beforeEach {
                    firstElement = Int.wtw.random()
                    rest = [Int.wtw.random(), Int.wtw.random(), Int.wtw.random()]
                    array = NonEmptyArray(firstElement: firstElement, rest: rest)
                }
                
                it("should create a NonEmptyArray with the first element being the given firstElement") {
                    expect(array[0]) == firstElement
                }
                
                it("should create a NonEmptyArray with the elements after the first element being the given rest array") {
                    expect(array[0]) == firstElement
                    expect(Array(array[1...3])) == rest
                }
            }
            
            describe("its init with array") {
                var array: [Int]!
                
                context("when the given array is empty") {
                    beforeEach {
                        array = []
                    }
                    
                    it("should return nil") {
                        expect(NonEmptyArray(array: array)).to(beNil())
                    }
                }
                
                context("when the given array is not empty") {
                    beforeEach {
                        array = [Int.wtw.random()]
                    }
                    
                    it("should create a NonEmptyArray with the elements equal to the given array's elements") {
                        expect(Array(NonEmptyArray(array: array)!)) == array
                    }
                }
            }
            
            describe("its count") {
                var elements: [Int]!
                var array: NonEmptyArray<Int>!
                
                beforeEach {
                    elements = [Int].wtw_random(size: Int.random(in: 1...10))
                    array = NonEmptyArray(array: elements)!
                }
                
                it("should be the count of its elements") {
                    expect(array.count) == elements.count
                }
            }
            
            describe("its first") {
                var expected: Int!
                var actual: Int!
                
                beforeEach {
                    let elements = [Int].wtw_random(size: Int.random(in: 3...8))
                    let array = NonEmptyArray(array: elements)!
                    
                    expected = elements.first!
                    
                    // This is required because otherwise it uses the Collection function instead of the NonEmptyArray function for some reason
                    let _actual = array.first
                    
                    actual = _actual
                }
                
                it("should return the first element") {
                    expect(actual) == expected
                }
            }
            
            describe("its last") {
                var expected: Int!
                var actual: Int!
                
                beforeEach {
                    let elements = [Int].wtw_random(size: Int.random(in: 3...8))
                    let array = NonEmptyArray(array: elements)!
                    
                    expected = elements.last!
                    actual = array.last
                }
                
                it("should return the last element") {
                    expect(actual) == expected
                }
            }
            
            describe("its isEmpty") {
                var array: NonEmptyArray<Int>!
                
                beforeEach {
                    array = NonEmptyArray(array: [Int.wtw.random()])!
                }
                
                it("should return false") {
                    expect(array.isEmpty).to(beFalse())
                }
            }
            
            describe("its insert contentsOf collection at index") {
                var array: NonEmptyArray<Int>!
                var insertedArray: [Int]!
                var insertionIndex: Int!
                
                beforeEach {
                    array = NonEmptyArray<Int>.wtw_random(size: Int.random(in: 3...8))!
                    
                    insertedArray = [Int].wtw_random(size: Int.random(in: 1...8))
                    insertionIndex = array.randomIndex()
                    
                    array.insert(contentsOf: insertedArray, at: insertionIndex)
                }
                
                it("should insert contents of the given collection at the given index") {
                    let insertionRange = insertionIndex..<(insertionIndex+insertedArray.count)
                    
                    expect(Array(array[insertionRange])) == insertedArray
                }
            }
            
            describe("its insert newElement at index") {
                var array: NonEmptyArray<Int>!
                var insertedElement: Int!
                var insertionIndex: Int!
                
                beforeEach {
                    array = NonEmptyArray<Int>.wtw_random(size: Int.random(in: 3...8))!
                    insertedElement = Int.wtw.random()
                    insertionIndex = array.randomIndex()
                    
                    array.insert(insertedElement, at: insertionIndex)
                }
                
                it("should insert the given element at the given index") {
                    expect(array[insertionIndex]) == insertedElement
                }
            }
            
            describe("its append newElement") {
                var array: NonEmptyArray<Int>!
                var newElement: Int!
                
                beforeEach {
                    array = NonEmptyArray<Int>.wtw_random(size: Int.random(in: 3...8))!
                    newElement = Int.wtw.random()
                    array.append(newElement)
                }
                
                it("should append the given element") {
                    expect(array.last) == newElement
                }
            }
            
            describe("its byAppending") {
                var array: NonEmptyArray<Int>!
                var newElement: Int!
                var newArray: NonEmptyArray<Int>!
                
                beforeEach {
                    array = NonEmptyArray<Int>.wtw_random(size: Int.random(in: 3...8))!
                    newElement = Int.wtw.random()
                    newArray = array.byAppending(newElement)
                }
                
                it("should return the array with the given element appended") {
                    expect(newArray.last) == newElement
                    expect(newArray) != array
                }
            }
            
            describe("its safe index") {
                var array: NonEmptyArray<Int>!
                
                beforeEach {
                    array = NonEmptyArray<Int>.wtw_random(size: Int.random(in: 3...8))!
                }
                
                context("when an element at the given index does not exist") {
                    it("should return nil") {
                        expect(array[safe: array.count]).to(beNil())
                    }
                }
                
                context("when an element at the given index exists") {
                    it("should return that element") {
                        let index = array.count - 1
                        
                        expect(array[safe: index]) == array[index]
                    }
                }
            }
            
            describe("its toArray") {
                var array: NonEmptyArray<Int>!
                
                beforeEach {
                    array = NonEmptyArray<Int>.wtw_random(size: Int.random(in: 3...8))!
                }
                
                it("should return an array of the elements") {
                    expect(array.toArray()) == Array(array)
                }
            }
            
            describe("its removeLastElementAndAddElementToStart") {
                var array: NonEmptyArray<Int>!
                var lastElement: Int!
                var addedElement: Int!
                
                beforeEach {
                    array = NonEmptyArray<Int>.wtw_random(size: Int.random(in: 3...8))!
                    lastElement = array.last
                    addedElement = Int.wtw.random()
                    array.removeLastElementAndAddElementToStart(addedElement)
                }
                
                it("should remove the last element") {
                    expect(array.last) != lastElement
                }
                
                it("should add the given element to the start of the array") {
                    expect(array.first) == addedElement
                }
            }
            
            describe("its removeFirstElementAndAddElementToEnd") {
                var array: NonEmptyArray<Int>!
                var firstElement: Int!
                var addedElement: Int!
                
                beforeEach {
                    array = NonEmptyArray<Int>.wtw_random(size: Int.random(in: 3...8))!
                    firstElement = array.first
                    addedElement = Int.wtw.random()
                    array.removeFirstElementAndAddElementToEnd(addedElement)
                }
                
                it("should remove the first element") {
                    expect(array.first) != firstElement
                }
                
                it("should add the given element to the end of the array") {
                    expect(array.last) == addedElement
                }
            }
            
            describe("its map") {
                var array: NonEmptyArray<Int>!
                var expectedArray: NonEmptyArray<String>!
                
                beforeEach {
                    array = NonEmptyArray<Int>.wtw_random(size: Int.random(in: 3...8))!
                    expectedArray = NonEmptyArray(array: array.toArray().map(String.init))!
                }
                
                it("should return an array of transformed elements") {
                    expect(array.map(String.init)) == expectedArray
                }
            }
            
            describe("its min by") {
                var expected: Int!
                var result: Int!
                
                beforeEach {
                    expected = Int.min
                    let array = NonEmptyArray(
                        array: [expected!, expected! + 1, expected! + 2, expected! + 3]
                    )!
                    
                    // Collection.min is used over NonEmptyAray.min for w/e reason
                    let _result = array.min(by: { $0 < $1 })
                    
                    result = _result
                }
                
                it("should return the minimum value based on the given closure") {
                    expect(result) == expected
                }
            }
            
            describe("its max by") {
                var expected: Int!
                var result: Int!
                
                beforeEach {
                    expected = Int.max
                    let array = NonEmptyArray(array: [expected!, expected! - 1, expected! - 2, expected! - 3])!
                    
                    // Collection.max is used over NonEmptyAray.max for w/e reason
                    let _result = array.max(by: { $0 < $1 })
                    
                    result = _result
                }
                
                it("should return the minimum value based on the given closure") {
                    expect(result) == expected
                }
            }
            
            describe("its reversed") {
                var expected: [Int]!
                var actual: [Int]!
                
                beforeEach {
                    let elements = [Int].wtw_random(size: Int.random(in: 3...8))
                    let array = NonEmptyArray(array: elements)!
                    
                    expected = elements.reversed()
                    actual = Array(array.reversed())
                }
                
                it("should return the same array only reversed") {
                    expect(actual) == expected
                }
            }
            
            describe("its randomIndex") {
                var first: Int!
                var second: Int!
                
                beforeEach {
                    let array = NonEmptyArray<Int>.wtw_random(size: Int.random(in: 2...100))!
                    
                    first = array.randomIndex()
                    second = array.randomIndex()
                }
                
                it("should return a random index in the given array") {
                    expect(first) != second
                }
            }
            
            describe("its randomElement") {
                var array: NonEmptyArray<Int>!
                var first: Int!
                var second: Int!
                
                beforeEach {
                    array = NonEmptyArray<Int>.wtw_random(size: Int.random(in: 2...100))!
                    first = array.randomElement()
                    second = array.randomElement()
                }
                
                it("should return a random element in the given array") {
                    expect(first) != second
                    expect(array).to(contain(first))
                    expect(array).to(contain(second))
                }
            }
            
            describe("it's init with range") {
                var expected: NonEmptyArray<Int>!
                var actual: NonEmptyArray<Int>!
                
                beforeEach {
                    let range = 0...4
                    expected = NonEmptyArray(array: Array(range))!
                    actual = NonEmptyArray(range: range)
                }
                
                it("should create a NonEmptyArray out of the given range") {
                    expect(actual) == expected
                }
            }
            
            describe("its description") {
                var elements: [Int]!
                var array: NonEmptyArray<Int>!
                
                beforeEach {
                    elements = [Int].wtw_random(size: Int.random(in: 3...8))
                    array = NonEmptyArray(array: elements)!
                }
                
                it("should return the description of its elements") {
                    expect(array.description) == elements.description
                }
            }
            
            describe("its debugDescription") {
                var elements: [Int]!
                var array: NonEmptyArray<Int>!
                
                beforeEach {
                    elements = [Int].wtw_random(size: Int.random(in: 3...8))
                    array = NonEmptyArray(array: elements)!
                }
                
                it("should return the debugDescription of its elements") {
                    expect(array.debugDescription) == elements.debugDescription
                }
            }
            
            describe("its startIndex") {
                var array: NonEmptyArray<Int>!
                
                beforeEach {
                    array = NonEmptyArray<Int>.wtw_random(size: Int.random(in: 3...8))!
                }
                
                it("should return zero") {
                    expect(array.startIndex) == 0
                }
            }
            
            describe("its endIndex") {
                var array: NonEmptyArray<Int>!
                
                beforeEach {
                    array = NonEmptyArray<Int>.wtw_random(size: Int.random(in: 3...8))!
                }
                
                it("should return its count") {
                    expect(array.endIndex) == array.count
                }
            }
            
            describe("its index after") {
                var array: NonEmptyArray<Int>!
                var index: Int!
                var expectedIndex: Int!
                
                beforeEach {
                    array = NonEmptyArray<Int>.wtw_random(size: Int.random(in: 3...8))!
                    index = array.randomIndex()
                    expectedIndex = index + 1
                }
                
                it("should return the index incremented once") {
                    expect(array.index(after: index)) == expectedIndex
                }
            }
            
            describe("its subscript") {
                context("when using the getter") {
                    var expected: Int!
                    var actual: Int!
                    
                    beforeEach {
                        let elements = [Int].wtw_random(size: Int.random(in: 3...8))
                        let array = NonEmptyArray(array: elements)!
                        let index = array.randomIndex()
                        
                        expected = elements[index]
                        actual = array[index]
                    }
                    
                    it("should return the element at the given index") {
                        expect(actual) == expected
                    }
                }
                
                context("when using the setter") {
                    var array: NonEmptyArray<Int>!
                    var inserted: Int!
                    var insertionIndex: Int!
                    
                    beforeEach {
                        array = NonEmptyArray<Int>.wtw_random(size: Int.random(in: 3...8))
                        inserted = Int.wtw.random()
                        insertionIndex = array.randomIndex()
                        
                        array[insertionIndex] = inserted
                    }
                    
                    it("should set the given value for the given index") {
                        expect(array[insertionIndex]) == inserted
                    }
                }
            }
            
            describe("its min") {
                var expected: Int!
                var actual: Int!
                
                beforeEach {
                    let elements = [Int].wtw_random(size: Int.random(in: 3...8))
                    expected = elements.min()!
                    
                    let array = NonEmptyArray(array: elements)!
                    
                    let _actual = array.min()
                    
                    actual = _actual
                }
                
                it("should return the min of its elements") {
                    expect(actual) == expected
                }
            }
            
            describe("its max") {
                var expected: Int!
                var actual: Int!
                
                beforeEach {
                    let elements = [Int].wtw_random(size: Int.random(in: 3...8))
                    expected = elements.max()!
                    
                    let array = NonEmptyArray(array: elements)!
                    actual = array.max()
                }
                
                it("should return the max of its elements") {
                    expect(actual) == expected
                }
            }
            
            describe("its maxIndex") {
                var expected: Int!
                var actual: Int!
                
                beforeEach {
                    let elements = [Int].wtw_random(size: Int.random(in: 3...8))
                    expected = elements.index(of: elements.max()!)
                    
                    let array = NonEmptyArray(array: elements)!
                    actual = array.maxIndex()
                }
                
                it("should return the index of the maximum value of its elements") {
                    expect(actual) == expected
                }
            }
            
            describe("its sort") {
                var elements: [Int]!
                var array: NonEmptyArray<Int>!
                
                beforeEach {
                    elements = [Int].wtw_random(size: Int.random(in: 3...8))
                    array = NonEmptyArray(array: elements)!
                    
                    elements.sort()
                    array.sort()
                }
                
                it("should sort its elements") {
                    expect(elements) == Array(array)
                }
            }
            
            describe("its sorted") {
                var expected: [Int]!
                var actual: [Int]!
                
                beforeEach {
                    let elements = [Int].wtw_random(size: Int.random(in: 3...8))
                    let array = NonEmptyArray(array: elements)!
                    
                    expected = elements.sorted()
                    actual = Array(array.sorted())
                }
                
                it("should return a sorted version of its elements") {
                    expect(actual) == expected
                }
            }
        }
    }
}
