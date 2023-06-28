import SwiftUI

@main
struct GithubUsersApp: App {

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
