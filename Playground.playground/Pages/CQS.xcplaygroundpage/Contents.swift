//: [Previous](@previous)
import Foundation

struct User {}

class BadService {
    var lastTimeFetchUser: Date?

    func fetchUser() -> User? {
        lastTimeFetchUser = Date()

        return User()
    }
}

class GoodService {

    var lastTimeFetchUser: Date?

    func fetchUser() -> User? {
        return User()
    }

    func updateLastTimeUserFetch() {
        lastTimeFetchUser = Date()
    }
}

class BadIncrementer {
    private var value: Int = 0

    func doSomethingAndFetchValue() -> Int {
        value += 100

        return value
    }
}

class GoodIncrementer {
    private var value: Int = 0

    func doSomething() {
        value += 100
    }

    func fetchValue() -> Int {
        return value
    }
}

//: [Next](@next)
