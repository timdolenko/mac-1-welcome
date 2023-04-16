import Foundation
import Combine

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

    init(user: User, repository: UserDetailRepository) {
        self.user = user
        self.repository = repository

        bio = "Loading..."

        Task {
            do {
                bio = try await repository.fetchBio(for: user).bio
            } catch {}
        }
    }
}
