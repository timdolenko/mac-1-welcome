import SwiftUI
import Swinject

class ListViewFactory {
    func makeListView() -> ListView {
        ListView(viewModel: makeUserListViewModel())
    }

    func makeUserListViewModel() -> UserListViewModel {
        let networkService = NetworkServiceMock()
        let mock = UserListRepositoryMock(networkService: networkService)

        let detailRepository = UserDetailRepositoryMock(networkService: networkService)

        let viewModel = UserListViewModel(
            repository: mock,
            detailRepository: detailRepository
        )

        return viewModel
    }
}

@main
struct GithubUsersApp: App {

    var container = Container()

    var body: some Scene {
        WindowGroup {

            let factory = ListViewFactory()
            factory.makeListView()
        }
    }
}
