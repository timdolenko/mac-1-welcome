//: [Previous](@previous)

import Foundation

protocol Locator {
    func resolve<T>() -> T?

    func register<T>(_ service: T)
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

protocol ServiceA {
    func doA()
}

class ServiceA1: ServiceA {
    func doA() { print("abc") }
}

class Client {

    private let locator: Locator

    init(locator: Locator) {
        self.locator = locator
    }

    func doSomething() {
        let a: ServiceA? = locator.resolve()
        a?.doA()
    }
}
let locator = LocatorImpl()
locator.register(Service())

let client = Client(locator: locator)
client.doSomething()
//: [Next](@next)
