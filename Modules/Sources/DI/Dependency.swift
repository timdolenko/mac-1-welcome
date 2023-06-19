import Foundation

@propertyWrapper
public struct Dependency<T> {
    public var wrappedValue: T {
        Container.shared.dependency()
    }

    public init() {}
}

//: [Next](@next)
