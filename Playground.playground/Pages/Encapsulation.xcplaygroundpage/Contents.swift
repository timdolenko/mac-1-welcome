//: [Previous](@previous)

import Foundation

class Counter {

    private(set) var value: Int = 0

    func increment() -> Int {
        value += 1
        return value
    }

    func decrement() -> Int {
        guard value > 0 else { return value }

        value -= 1
        return value
    }
}

let counter = Counter()

print(counter.increment()) //1
print(counter.increment()) //2
print(counter.increment()) //3
print(counter.increment()) //4
print(counter.increment()) //5
print(counter.decrement()) //4
print(counter.decrement()) //3

//: [Next](@next)
