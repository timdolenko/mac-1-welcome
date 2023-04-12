import Foundation

public struct User: Identifiable, Hashable {
    public init(id: Int, avatarURL: String, login: String, publicRepos: Int? = nil) {
        self.id = id
        self.avatarURL = avatarURL
        self.login = login
        self.publicRepos = publicRepos
    }

    public let id: Int
    public let avatarURL: String
    public let login: String
    public let publicRepos: Int?
}
