//: [Previous](@previous)

import Foundation

/// `Encapsulation` is needed to indicate intent and to avoid undesired access and errors states.

/// `Counter` increases it's value up to `maxValue`, and then switches to 0.
/// It can also decrease it's value, but not going below 0.
class Counter {

    var maxValue: Int = 10

    var value: Int = 0

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

let counter = Counter()
counter.maxValue = 3

print(counter.increment())
print(counter.increment())
print(counter.increment())
counter.maxValue = 4
counter.value = 2
print(counter.increment())

//: [Next](@next)
