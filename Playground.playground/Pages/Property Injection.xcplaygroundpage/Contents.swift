//: [Previous](@previous)

import Foundation

// MARK: Property Injection

protocol ServiceA {
    func doA()
}

class ServiceA1: ServiceA {
    func doA() {
        print("abc")
    }
}

class Client {

    var a: ServiceA!

    init() {}

    func doSomething() {
        a.doA()
    }
}

let client = Client()
client.a = ServiceA1()
client.doSomething()














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
//    var dependency: Dependency!
//
//    func foo() {
//        dependency.foo()
//    }
//}
//
//let client = Client()
//client.dependency = DependencyLive()
//client.foo()

//: [Next](@next)
