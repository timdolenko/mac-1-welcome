//: [Previous](@previous)

import Foundation

// MARK: High Coupling

class ServiceX {
    func doX() {
        ServiceA().doA()
    }
}

class ServiceZ {
    func doZ() {
        ServiceA().doA()
    }
}

/// `ServiceA` uses 2 external concrete classes
/// It's used by 2 external classes too
class ServiceA {
    func doSomething() {
        ServiceX().doX()
        ServiceZ().doZ()
    }

    func doA() {}
}



//: [Next](@next)
