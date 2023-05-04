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

protocol PageRepository {
    func fetch(page: Int, size: Int) async throws -> [String]
}

protocol CounterType {
    var value: Int { get }
    func increment() -> Int
    func decrement() -> Int
}

extension Counter: CounterType {}

class Pager {
    private let counter: CounterType = Counter()
    private let repository: PageRepository
    private let pageSize: Int = 3
    private(set) var result: [String] = []

    init(repository: PageRepository) {
        self.repository = repository
    }

    func next() async throws -> [String] {
        let newPage = counter.increment()
        let result = try await repository
            .fetch(page: newPage, size: pageSize)

        self.result.append(contentsOf: result)
        return self.result
    }
}

class FakeRepository: PageRepository {
    func fetch(page: Int, size: Int) async throws -> [String] {
        [String](repeating: "\(page) \(size)", count: size)
    }
}

Task {
    let pager = Pager(repository: FakeRepository())
    try? await pager.next()
    try? await pager.next()
}

//: [Next](@next)
