//: [Previous](@previous)

import Foundation

class Handler {

    func handle() {
        let data = request()
        let array = parseResponse(data: data)
        saveToDatabase(array: array)
    }

    private func request() -> Data {
        // Do a network request and wait for the response
        fatalError()
    }

    private func parseResponse(data: Data) -> [String] {
        // Parse the network response into an array
        fatalError()
    }

    private func saveToDatabase(array: [String]) {
        // Save the parsed response into the database
        fatalError()
    }
}

//: [Next](@next)
