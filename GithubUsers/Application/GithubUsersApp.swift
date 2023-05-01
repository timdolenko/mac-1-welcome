import SwiftUI
import Swinject

@main
struct GithubUsersApp: App {
    var container = Container()

    init() {
        Assembly().inject(into: container)
    }

    var body: some Scene {
        WindowGroup {
//            let viewModel = UserListViewModel(container: container)

//            ListView(viewModel: viewModel)

//            SetPasswordSolutionView()
        }
    }
}
