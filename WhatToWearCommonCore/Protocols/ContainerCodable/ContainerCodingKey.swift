import Foundation

public protocol ContainerCodingKey: CodingKey {
    static var allValues: [Self] { get }
}
