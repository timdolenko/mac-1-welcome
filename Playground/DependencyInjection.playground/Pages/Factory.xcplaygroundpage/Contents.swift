//: [Previous](@previous)

import Foundation

protocol ServiceA {
    func doA()
}

class ServiceA1: ServiceA {
    func doA() { print("abc") }
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

class ClientFactory {
    func make() -> Client {
        let a = ServiceA1()
        return Client(a: a)
    }
}

let client = ClientFactory().make()
client.doSomething()

//: [Next](@next)
