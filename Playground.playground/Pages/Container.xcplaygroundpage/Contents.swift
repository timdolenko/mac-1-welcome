//: [Previous](@previous)

import Foundation

protocol Locator {
    func resolve<T>() -> T?
}

final class LocatorImpl: Locator {
    private var services: [ObjectIdentifier: Any] = [:]

    func register<T>(_ service: T) {
        services[key(for: T.self)] = service
    }

    func resolve<T>() -> T? {
        return services[key(for: T.self)] as? T
    }

    private func key<T>(for type: T.Type) -> ObjectIdentifier {
        return ObjectIdentifier(T.self)
    }
}

class Client {
    private let locator: Locator

    init(locator: Locator) {
        self.locator = locator
    }

    func doSomething() {
        guard let service: Service = locator.resolve() else { return }
        // do something with service
    }
}

class Service {}

//: [Next](@next)
