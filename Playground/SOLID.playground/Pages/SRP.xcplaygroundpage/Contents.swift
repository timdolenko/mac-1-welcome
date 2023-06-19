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
        let array = parser.parseResponse(data: data)
        persistence.saveToDatabase(array: array)
    }
}

class Repository {
    func request() -> Data {
        // Do a network request and wait for the response
        fatalError()
    }
}

class Parser {
    func parseResponse(data: Data) -> [String] {
        // Parse the network response into an array
        fatalError()
    }
}

class PersistenceManager {
    func saveToDatabase(array: [String]) {
        // Save the parsed response into the database
        fatalError()
    }
}

//: [Next](@next)
