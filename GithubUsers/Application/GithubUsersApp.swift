import SwiftUI

@main
struct GithubUsersApp: App {
    var body: some Scene {
        WindowGroup {
            let networkService = NetworkServiceMock()
            let mock = UserListRepositoryMock(networkService: networkService)
            let viewModel = UserListViewModel(repository: mock)
            ListView(viewModel: viewModel)
        }
    }
}
