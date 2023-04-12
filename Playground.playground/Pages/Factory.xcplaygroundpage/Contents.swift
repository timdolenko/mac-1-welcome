//: [Previous](@previous)

import Foundation

protocol Client {}

enum ClientFactory {

    static func make() -> Client {
        ClientLive(dependency: DependencyLive())
    }
}

class ClientLive: Client {
    init(dependency: Dependency) {}
}

protocol Dependency {}
struct DependencyLive: Dependency {}

//: [Next](@next)
