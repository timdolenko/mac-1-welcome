//: [Previous](@previous)

import Foundation

// MARK: Low Coupling

protocol ServiceX {
    func doX()
}

class ServiceXLive: ServiceX {

    private let a: ServiceA

    init(a: ServiceA) {
        self.a = a
    }

    func doX() {
        a.doA()
    }
}

protocol ServiceZ {
    func doZ()
}

class ServiceZLive: ServiceZ {

    private let a: ServiceA

    init(a: ServiceA) {
        self.a = a
    }

    func doZ() {
        a.doA()
    }
}

protocol ServiceA {
    func doSomething()
    func doA()
}

/// `ServiceA` uses 0 external concrete classes
/// It's used by 0 external classes too
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

class ServiceATests {

    func test_() {

    }
}

//: [Next](@next)
