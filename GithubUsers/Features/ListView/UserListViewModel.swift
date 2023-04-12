import Foundation
import Combine

protocol UserListRepository {
    func users() async throws -> [User]
}

class UserListViewModel: ObservableObject {

    @Published var users: [User] = []
    @Published var selectedUser = User(
        id: 0,
        avatarURL: "",
        login: "",
        publicRepos: 0
    )

    private let repository: UserListRepository

    init(repository: UserListRepository) {
        self.repository = repository

        fetch()
    }

    func detailViewModel(for user: User) -> UserDetailViewModel {
        UserDetailViewModel(user: user)
    }

    private func fetch() {
        Task {
            do {
                users = try await repository.users()
            } catch {}
        }
    }
}
