import Foundation
import Combine
import Swinject

class UserDetailViewModel: ObservableObject {

    @Published var bio: String

    var profilePictureURL: String {
        user.avatarURL
    }

    var username: String {/// Can be localized
        "Username: \(user.login)"
    }

    var publicRepositories: String {
        "Public repositories: \(user.publicRepos ?? 0)"
    }

    private let user: User
    private let repository: UserDetailRepository

    init(user: User, container: Container) {
        self.user = user
        self.repository = container.resolve(UserDetailRepository.self)!

        bio = "Loading..."

        Task {
            do {
                bio = try await repository.fetchBio(for: user).bio
            } catch {}
        }
    }
}
