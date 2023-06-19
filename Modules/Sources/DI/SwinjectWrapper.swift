import Foundation
import Swinject

final class SwinjectWrapper: ContainerWrapper {

    private let container = Swinject.Container()

    func register<T>(_ type: T.Type, _ scope: Container.ObjectScope<T>) {
        switch scope {
        case let .object(obj):
            container.register(T.self) { _ in
                obj
            }
            .inObjectScope(.container)
        case let .weak(obj):
            container.register(T.self) { _ in
                obj
            }
            .inObjectScope(.weak)
        case let .factory(factory):
            container.register(T.self) { _ in
                factory()
            }
            .inObjectScope(.container)
        case let .prototype(factory):
            container.register(T.self) { _ in
                factory()
            }
            .inObjectScope(.transient)
        }
    }

    func dependency<T>() -> T {
        container.resolve(T.self)!
    }
}
