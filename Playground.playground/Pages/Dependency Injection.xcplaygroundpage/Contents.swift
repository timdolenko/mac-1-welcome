//: [Previous](@previous)

import Foundation

// MARK: Initializer Injection

protocol ServiceA {
    func doA()
}

class ServiceA1: ServiceA {

    weak var client: Client!

    func doA() {
        print("abc")
    }
}

class Client {

    var a: ServiceA!

    func doSomething() {
        a.doA()
    }
}

let service = ServiceA1()
let client = Client()
client.a = service
service.client = client





















//protocol Engine {
//    func woo()
//    func stop()
//}
//
//class Car {
//    private let engine: Engine
//
//    init(
//        engine: Engine
//    ) {
//        self.engine = engine
//    }
//}
//
//
//
//
//
//
//
//protocol Dependency {
//    func foo()
//}
//
//struct DependencyLive: Dependency {
//    func foo() {
//        print("I am alive!")
//    }
//}
//
//class Client {
//    let dependency: Dependency
//
//    init(dependency: Dependency) {
//        self.dependency = dependency
//    }
//
//    func foo() {
//        dependency.foo()
//    }
//}
//
//let client = Client(dependency: DependencyLive())
//client.foo()
//
////: [Next](@next)
