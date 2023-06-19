import Foundation

public protocol Identifiable {}

public extension Identifiable {
    static var identifier: String {
        String(describing: self)
    }
}
