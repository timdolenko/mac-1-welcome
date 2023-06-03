import Foundation

@propertyWrapper
public struct Dependency<T> {
    public var wrappedValue: T {
        Container.shared.dependency()
    }

    public init() {}
}

public class Container {
    public static var shared: Container = Container()

    private var storage: [ObjectIdentifier: Any] = [:]
    private let lock = NSRecursiveLock()

    public init() {}

    static func register<T>(_ obj: T, for type: T.Type) {
        shared.register(obj, for: type)
    }

    func register<T>(_ obj: T, for type: T.Type) {
        storage[ObjectIdentifier(type)] = obj
    }

    func dependency<T>() -> T {
        self.lock.lock()
        defer { self.lock.unlock() }

        return storage[ObjectIdentifier(T.self)] as! T
    }
}
