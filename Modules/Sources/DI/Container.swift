import Foundation

public protocol ContainerWrapper {
    func register<T>(_ type: T.Type, _ scope: Container.ObjectScope<T>)
    func dependency<T>() -> T
}

public class Container {

    public static var shared: Container = Container(implementation: SwinjectWrapper())

    public enum ObjectScope<T> {
        case object(T)
        case factory(()->T)
        case prototype(()->T)
        case weak(T)
    }

    private var implementation: ContainerWrapper

    public init(implementation: ContainerWrapper) {
        self.implementation = implementation
    }

    public func register<T>(_ type: T.Type, _ scope: ObjectScope<T>) {
        implementation.register(type, scope)
    }

    public func dependency<T>() -> T {
        implementation.dependency()
    }
}

public extension Container {
    static func wipe() {
        Container.shared = Container(implementation: SwinjectWrapper())
    }
}

public extension Container {
    static func register<T>(_ type: T.Type, _ obj: T) {
        shared.register(type, .object(obj))
    }

    static func register<T>(_ type: T.Type, _ factory: @escaping () -> T) {
        shared.register(type, .factory(factory))
    }

    static func register<T>(_ type: T.Type, _ scope: ObjectScope<T>) {
        shared.register(type, scope)
    }
}
