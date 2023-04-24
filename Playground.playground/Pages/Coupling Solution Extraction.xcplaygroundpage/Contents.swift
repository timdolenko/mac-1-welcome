//: [Previous](@previous)

import Foundation

protocol ServiceX {
    func doX()
}

protocol ServiceZ {
    func doZ()
}

protocol ServiceA {
    func doSomething()
    func doA()
}

class ServiceALive: ServiceA {

    private let x: ServiceX
    private let z: ServiceZ

    init(x: ServiceX, z: ServiceZ) {
        self.x = x
        self.z = z
    }

    func doSomething() {
        x.doX()
        z.doZ()
    }

    func doA() {}
}

class ServiceXSubstitute: ServiceX {
    func doX() {}
}

class ServiceZSubstitute: ServiceZ {
    func doZ() {}
}

let a = ServiceALive(x: ServiceXSubstitute(), z: ServiceZSubstitute())
a.doSomething()

//: [Next](@next)
