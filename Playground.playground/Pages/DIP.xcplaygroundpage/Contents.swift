//: [Previous](@previous)

import Foundation

struct UserPreference: Encodable {
    let sectionId: String
    let isHidden: Bool
}

public struct Endpoint {
    public var path: String
    public var body: Encodable? = nil
}

class Network {
    func request(_ endpoint: Endpoint) { print("sending request \(endpoint.path)") }
}

public class UserPreferences {

    private let network: Network

    init(network: Network) {
        self.network = network
    }

    func hideMenu() {
        let userPreference = UserPreference(sectionId: "menu", isHidden: true)
        let endpoint = Endpoint(path: "/preference", body: userPreference)
        network.request(endpoint)
    }
}

//: [Next](@next)
