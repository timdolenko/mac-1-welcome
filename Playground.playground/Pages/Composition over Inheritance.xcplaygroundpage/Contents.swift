//: [Previous](@previous)

import Foundation

protocol CounterType {
    var value: Int { get }
    func increment()
    func decrement()
}

class Counter {

    private(set) var value: Int = 0

    var maxValue: Int = 10

    func increment() -> Int {
        guard value < maxValue else {
            value = 0
            return value
        }

        value += 1
        return value
    }

    func decrement() -> Int {
        guard value > 0 else { return value }

        value -= 1
        return value
    }
}

class Pager {

    let counter = Counter()

    var currentPage: Int = 0
    var results: [String] = []

    func next() {
        counter.increment()

        fetchData(for: counter.value)
    }

    func previous() {

    }

    func fetchData(for page: Int) -> String {
        return "I call network service here"
    }
}

let pager = Pager()
pager.next()




//: [Next](@next)
