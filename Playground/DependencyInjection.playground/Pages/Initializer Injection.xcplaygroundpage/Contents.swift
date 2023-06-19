//: [Previous](@previous)

import Foundation

// MARK: Initializer Injection

protocol ServiceA {
    func doA()
}

class ServiceA1: ServiceA {
    func doA() {
        print("abc")
    }
}

class Client {

    let a: ServiceA

    init(a: ServiceA) {
        self.a = a
    }

    func doSomething() {
        a.doA()
    }
}

class ServiceA2: ServiceA {
    func doA() {
        print("xyz")
    }
}

let client = Client(a: ServiceA1())
client.doSomething() // `abc`

let client2 = Client(a: ServiceA2())
client2.doSomething()// `xyz`

////: [Next](@next)
