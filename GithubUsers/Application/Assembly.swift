import Foundation
import Swinject

class Assembly {
    func inject(into container: Container) {
        container.register(NetworkService.self) { _ in
            NetworkServiceMock()
        }

        container.register(UserListRepository.self) { container in
            UserListRepositoryMock(
                networkService: container.resolve(NetworkService.self)!
            )
        }

        container.register(UserDetailRepository.self) { container in
            UserDetailRepositoryMock(
                networkService: container.resolve(NetworkService.self)!
            )
        }
    }
}
