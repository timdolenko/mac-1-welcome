//: [Previous](@previous)

import Foundation

// MARK: Ambient Context

protocol Router {
    func route()
}

class RouterLive: Router {
    func route() {
        print("way A")
    }
}

class AnotherRouter: Router {
    func route() {
        print("way B")
    }
}

class Routers {
    static var shared: Router = RouterLive()
}

class Client {
    func doSomething() {
        Routers.shared.route()
    }
}

Routers.shared = AnotherRouter()
Client().doSomething()



















//: [Next](@next)
