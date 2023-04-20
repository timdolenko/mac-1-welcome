import Foundation
import Combine
import Swinject

protocol UserListRepository {
    func users() async throws -> [User]
}

class UserListViewModel: ObservableObject {

    @Published var users: [User] = []

    private let container: Container
    private let repository: UserListRepository

    init(container: Container) {
        self.container = container
        self.repository = container.resolve(UserListRepository.self)!

        fetch()
    }

    func detailViewModel(for user: User) -> UserDetailViewModel {
        UserDetailViewModel(user: user, container: container)
    }

    private func fetch() {
        Task {
            do {
                users = try await repository.users()
            } catch {}
        }
    }
}
