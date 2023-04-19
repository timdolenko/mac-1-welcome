//: [Previous](@previous)

//7 `things` with 3 `cohesion score`
class GodService {

    let userName = "Mark"//0

    var isEnabled: Bool = false//1
    var counter: Int = 0//2

    func incrementCounter() {//0
        counter += 1
    }

    func decrementCounter() {//0
        counter -= 1
    }

    func switchEnabled() {//0
        isEnabled = !isEnabled
    }

    func doSomething() {//0
        print("Hey!")
    }
}











//7 `things` with 7 `cohesion score`
class FocusedService {

    let userName = "Mark"//1

    var isEnabled: Bool = false//1
    var counter: Int = 0//2

    func launch() {//0
        if isEnabled {
            launchEnabled()
        } else {
            launchDisabled()
        }
    }

    private func launchDisabled() {//1
        counter -= 1
    }

    private func launchEnabled() {//1
        counter += 1
        printSomething()
    }

    private func printSomething() {//1
        print("Hey, \(userName)")
    }
}


//: [Next](@next)
