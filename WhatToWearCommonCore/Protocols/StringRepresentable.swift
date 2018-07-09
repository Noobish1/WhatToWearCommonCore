import Foundation

public protocol StringRepresentable {
    var stringRepresentation: String { get }
}

extension StringRepresentable where Self: LosslessStringConvertible {
    public var stringRepresentation: String {
        return String(self)
    }
}

extension Float: StringRepresentable {}
extension Double: StringRepresentable {}
extension String: StringRepresentable {}
