//: [Previous](@previous)

import Foundation

class UserAccountRepository {
    func doSomething() {
        let service: Service = container.resolve()
        return service.request()
    }

    var doSomething: (Int) -> Void = { print($0) }

    func fetchRepositoryIfPossible() {

    }

    func didAuthenticateUser() {

    }
}

//: [Next](@next)
