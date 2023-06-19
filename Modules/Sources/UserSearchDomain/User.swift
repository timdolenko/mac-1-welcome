import Foundation

public struct User {
    public init(name: String, profileImageUrl: URL) {
        self.name = name
        self.profileImageUrl = profileImageUrl
    }

    public let name: String
    public let profileImageUrl: URL
}
