//: [Previous](@previous)

import Foundation

// MARK: - Function Structure

/// 1. Keep arguments under  3

func doSomething(dependencyA: String, dependencyB: String, parameterZ: String, parameterX: String, argumentA: String) {}// ❌

/// 2. Sort Functions according ot the step down principle


example("reversed / chaotic") { // ❌
    func doA() {}

    func doZ() {}

    func doX() {
        doA()
    }

    func process() {
        doX()
        doZ()
    }
}

example("step down") {  // ✅
    func process() {
        doX()
        doZ()
    }

    func doX() {
        doA()
    }

    func doA() {}

    func doZ() {}
}


//: [Next](@next)
