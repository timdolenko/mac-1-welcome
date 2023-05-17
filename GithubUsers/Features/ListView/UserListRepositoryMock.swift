import Foundation


class UserListRepositoryMock: UserListRepository {

    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func users() async throws -> [User] {
        let avatarURL = "https://picsum.photos/200"

        return [
            User(id: 0, avatarURL: avatarURL, login: "Nick", publicRepos: 129),
            User(id: 1, avatarURL: avatarURL, login: "Mike", publicRepos: 31),
            User(id: 2, avatarURL: avatarURL, login: "Alex", publicRepos: 56)
        ]
    }
}
