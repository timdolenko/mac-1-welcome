//: [Previous](@previous)

import Foundation

class Handler {
    private let repository: Repository
    private let parser: Parser
    private let persistence: PersistenceManager

    init(
        repository: Repository,
        parser: Parser,
        persistence: PersistenceManager
    ) {
        self.repository = repository
        self.parser = parser
        self.persistence = persistence
    }

    func handle() {
        let data = repository.request()
        let array = parser.parse(data)
        persistence.save(array)
    }
}

class Repository {
    func request() -> Data { fatalError() }
}

class Parser {
    func parse(_ response: Data) -> [String] { fatalError() }
}

class PersistenceManager {
    func save(_ array: [String]) { fatalError() }
}

//: [Next](@next)


//: [Next](@next)
