//: [Previous](@previous)

import Foundation

// MARK: Initializer Injection

protocol Dependency {
    func foo()
}

struct DependencyLive: Dependency {
    func foo() {
        print("I am alive!")
    }
}

class Client {
    let dependency: Dependency

    init(dependency: Dependency) {
        self.dependency = dependency
    }

    func foo() {
        dependency.foo()
    }
}

let client = Client(dependency: DependencyLive())
client.foo()

//: [Next](@next)
