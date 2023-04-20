import SwiftUI
import Swinject

@main
struct GithubUsersApp: App {

    var container = Container()

    var body: some Scene {
        WindowGroup {
            let networkService = NetworkServiceMock()
            let mock = UserListRepositoryMock(networkService: networkService)

            let detailRepository = UserDetailRepositoryMock(networkService: networkService)

            let viewModel = UserListViewModel(
                repository: mock,
                detailRepository: detailRepository
            )

            ListView(viewModel: viewModel)
        }
    }
}
