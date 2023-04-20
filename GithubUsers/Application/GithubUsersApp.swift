import SwiftUI
import Swinject

@main
struct GithubUsersApp: App {

    private let container = Container()

    init() {
        Assembly().inject(into: container)
    }

    var body: some Scene {
        WindowGroup {
            ListView(viewModel: UserListViewModel(
                container: container
            ))
        }
    }
}


