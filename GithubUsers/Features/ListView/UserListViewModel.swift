import Foundation
import Combine

protocol UserListRepository {
    func users() async throws -> [User]
}

class UserListViewModel: ObservableObject {

    @Published var users: [User] = []

    private let repository: UserListRepository
    private let detailRepository: UserDetailRepository

    init(repository: UserListRepository, detailRepository: UserDetailRepository) {
        self.repository = repository
        self.detailRepository = detailRepository

        fetch()
    }

    func detailViewModel(for user: User) -> UserDetailViewModel {
        UserDetailViewModel(user: user, repository: detailRepository)
    }

    private func fetch() {
        Task {
            do {
                users = try await repository.users()
            } catch {}
        }
    }
}
