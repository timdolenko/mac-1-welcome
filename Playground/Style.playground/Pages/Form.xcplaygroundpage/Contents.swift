//: [Previous](@previous)

import Foundation

// MARK: - Form

/// 1. Every time you write a comment - you fail. Keep them rare.
/// 2. Commented out code should be removed immediately. Git will save the deleted data anyway.
/// 3. Lines should always fit on the screen. Keep lines small

// ❌
func doSomethingVeryComplicated<T>(parameterA: String, parameterB: Int, dependencyA: String) throws -> Result<T, Error> where T: CustomStringConvertible {
    fatalError()
}

// ✅
func doSomethingVeryComplicatedAgain<T>(
    parameterA: String,
    parameterB: Int,
    dependencyA: String
) throws -> Result<T, Error> where T: CustomStringConvertible {
    fatalError()
}

/// 4. Keep your files small. The average file should be less then 100 lines. Never exceed 500.
/// One class/structure/protocol per file
/// Class extensions can be extracted into separate classes

/// 5. Classes vs Data Structures. Classes provide functionality, data structures don't have any functionality and have public fields. Don't put business rules into data structures.

example("data structure vs class") {
    struct Region {
        let id: String
        let name: String
    }

    class RegionService {
        private var selectedRegion: Region?

        func executeBusinessLogic() {
            // do something
        }
    }
}

/// 6. Domain objects != Database tables. Separate your domain objects from your database putting a layer between them.

/// Data Transfer Object (DTO)
/// Represents backend responses
public struct Item: Decodable {
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case avatarUrl = "avatar_url"
    }

    public let login: String
    public let id: Int
    public let avatarUrl: String
}

/// Domain object. Is operated upon in business logic
public struct User {
    public init(name: String, profileImageUrl: URL) {
        self.name = name
        self.profileImageUrl = profileImageUrl
    }

    public let name: String
    public let profileImageUrl: URL
}

protocol Network {
    func request<T>(with path: String) -> T
}

class Repository {

    var network: Network!

    func requestUsers() -> [User] {
        let items: [Item] = network.request(with: "/users")
        return items.compactMap { $0.toDomain }
    }
}

/// Mapping layer
extension Item {
    var toDomain: User? {
        guard let url = URL(string: avatarUrl) else { return nil }
        return User(name: login, profileImageUrl: url)
    }
}


/// 7. DRY: Don't Repeat Yourself
/// Unless for the sake of simplicity / readability
/// Sometimes DRY = overengenering
/// Example: trying to reuse view code for 2 different views
/// Solution: Just copy and paste view code and make them 2 different views

/// 8. Readability over over-engineering / slight performance increase
/// It's much better to have clear, readable code than code that uses 20% less CPU power

//: [Next](@next)
