//: [Previous](@previous)

import Foundation

public struct UserPreference: Encodable {
    let sectionId: String
    let isHidden: Bool
}

public struct Endpoint {
    public var path: String
    public var body: Encodable? = nil
}

protocol Network {
    func request(_ endpoint: Endpoint)
}

class NetworkLive: Network {
    func request(_ endpoint: Endpoint) { print("sending request \(endpoint.path)") }
}

public protocol UserPreferencesRepository {
    func setUserPreference(_ preference: UserPreference)
}

public class UserPreferencesRepositoryLive: UserPreferencesRepository {

    private let network: Network

    init(network: Network) {
        self.network = network
    }

    public func setUserPreference(_ preference: UserPreference) {
        let endpoint = Endpoint(path: "/preference", body: preference)
        network.request(endpoint)
    }
}

public class UserPreferences {

    private let repository: UserPreferencesRepository

    init(repository: UserPreferencesRepository) {
        self.repository = repository
    }

    func hideMenu() {
        let userPreference = UserPreference(sectionId: "menu", isHidden: true)
        repository.setUserPreference(userPreference)
    }
}
//: [Next](@next)
