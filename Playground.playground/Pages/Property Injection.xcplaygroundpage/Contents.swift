//: [Previous](@previous)

import Foundation

// MARK: Property Injection

protocol Dependency {
    func foo()
}

struct DependencyLive: Dependency {
    func foo() {
        print("I am alive!")
    }
}

class Client {
    var dependency: Dependency!

    func foo() {
        dependency.foo()
    }
}

let client = Client()
client.dependency = DependencyLive()
client.foo()

//: [Next](@next)
