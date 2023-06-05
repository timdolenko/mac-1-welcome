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

    private struct LazyWrapper<T> {
        lazy var value: T = factory()

        private var factory: () -> T

        init(factory: @escaping () -> T) {
            self.factory = factory
        }
    }

    private enum Factory {
        case lazy(LazyWrapper<Any>)
        case prototype(() -> Any)
    }

    private enum Registration {
        case object(Any)
        case factory(Factory)
    }

    public enum ObjectScope<T> {
        case object(T)
        case lazy(()->T)
        case prototype(()->T)
        case weak(T)
    }

    private var storage: [ObjectIdentifier: Registration] = [:]
    private let lock = NSRecursiveLock()

    public init() {}

    func register<T>(_ type: T.Type, _ obj: T) {
        storage[ObjectIdentifier(type)] = .object(obj)
    }

    func register<T>(_ type: T.Type, _ factory: @escaping () -> T) {
        storage[ObjectIdentifier(type)] = .factory(.lazy(LazyWrapper(factory: factory)))
    }

    func register<T>(_ type: T.Type, _ scope: ObjectScope<T>) {
        switch scope {
        case .object(let obj):
            storage[ObjectIdentifier(type)] = .object(obj)
        case .weak(let obj):
            let anyObject = obj as AnyObject
            storage[ObjectIdentifier(type)] = .factory(.prototype({ [weak anyObject] in anyObject as! T }))
        case .lazy(let factory):
            storage[ObjectIdentifier(type)] = .factory(.lazy(LazyWrapper(factory: factory)))
        case .prototype(let factory):
            storage[ObjectIdentifier(type)] = .factory(.prototype(factory))
        }
    }

    func dependency<T>() -> T {
        self.lock.lock()
        defer { self.lock.unlock() }

        guard
            let registration = storage[ObjectIdentifier(T.self)]
        else {
            fatalError("\(T.self) was resolved before registration.")
        }

        switch registration {
        case .object(let obj):
            return obj as! T
        case .factory(let factory):
            switch factory {
            case .lazy(var wrapper):
                return wrapper.value as! T
            case .prototype(let factory):
                return factory() as! T
            }
        }
    }
}

extension Container {
    static func register<T>(_ type: T.Type, _ obj: T) {
        shared.register(type, obj)
    }

    static func register<T>(_ type: T.Type, _ factory: @escaping () -> T) {
        shared.register(type, factory)
    }

    static func register<T>(_ type: T.Type, _ scope: ObjectScope<T>) {
        shared.register(type, scope)
    }
}
