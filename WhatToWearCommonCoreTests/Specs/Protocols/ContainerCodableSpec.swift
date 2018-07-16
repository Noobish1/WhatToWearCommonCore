import Quick
import Nimble
import Foundation
import Fakery
@testable import WhatToWearCommonCore

private struct TestModel: Equatable {
    internal let firstName: String
    internal let lastName: String
}

extension TestModel: ContainerCodable {
    fileprivate enum CodingKeys: String, ContainerCodingKey {
        case firstName = "firstName"
        case lastName = "lastName"
        
        internal static let allValues: [CodingKeys] = [.firstName, .lastName]
    }
    
    // MARK: ContainerEncodable
    internal func encodeValue(forKey key: CodingKeys, in container: inout KeyedEncodingContainer<CodingKeys>) throws {
        switch key {
            case .firstName: try container.encode(firstName, forKey: key)
            case .lastName: try container.encode(lastName, forKey: key)
        }
    }
    
    // MARK: ContainerDecodable
    internal init(from container: KeyedDecodingContainer<CodingKeys>) throws {
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
    }
}

internal final class ContainerCodableSpec: QuickSpec {
    internal override func spec() {
        describe("ContainerCodable") {
            var faker: Faker!
            
            beforeEach {
                faker = Faker()
            }
            
            describe("a conforming model") {
                var model: TestModel!
                
                beforeEach {
                    model = TestModel(
                        firstName: faker.name.firstName(),
                        lastName: faker.name.lastName()
                    )
                }
                
                it("should be encodable") {
                    expect(expression: {
                        try JSONEncoder.wtwEncoder().encode(model)
                    }).toNot(throwError())
                }
                
                describe("its encoded form") {
                    var data: Data!
                    
                    beforeEach {
                        data = try! JSONEncoder.wtwEncoder().encode(model)
                    }
                    
                    it("should be decodable") {
                        expect(expression: {
                            try JSONDecoder.wtwDecoder().decode(TestModel.self, from: data)
                        }).toNot(throwError())
                    }
                }
            }
        }
    }
}