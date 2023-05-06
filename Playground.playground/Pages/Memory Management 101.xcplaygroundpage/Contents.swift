//: [Previous](@previous)

import Foundation

func healthy() {
    class App {
        var container: Container? = Container()
    }

    class Container {
        var repository: Repository? = Repository()

        deinit { print("Container left the memory") }
    }

    class Repository {
        deinit { print("Repository left the memory") }
    }

    var app = App()
    app.container = nil
}

//healthy()

func memoryLeak() {
    class App {
        var container: Container? = Container()
    }

    class Container {
        var repository: Repository? = Repository()

        init() {
            repository?.container = self
        }

        deinit { print("Container left the memory") }
    }

    class Repository {
//        var container: Container!
        weak var container: Container!

        deinit { print("Repository left the memory") }
    }

    var app = App()
    app.container = nil
}

memoryLeak()

//: [Next](@next)
