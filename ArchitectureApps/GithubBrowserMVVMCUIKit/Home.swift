import Foundation
import SwiftUI
import UserSearchMVVMCUIKit
import Util

class HomeCoordinator: Coordinator {

    private var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let actions = HomeViewModelActions(goToSearch: openSearch)
        let viewModel = HomeViewModel(actions: actions)
        let view = UIHostingController(rootView: HomeView(viewModel: viewModel))
        navigationController.pushViewController(view, animated: false)
    }

    func openSearch() {
        let coordinator = UserSearchCoordinator(
            navigationController: navigationController
        )

        coordinator.start()
    }
}

struct HomeViewModelActions {
    var goToSearch: () -> ()

    init(goToSearch: @escaping () -> Void) {
        self.goToSearch = goToSearch
    }
}

class HomeViewModel {

    private let actions: HomeViewModelActions

    init(actions: HomeViewModelActions) {
        self.actions = actions
    }
    
    func didTapGoToSearch() {
        actions.goToSearch()
    }
}

struct HomeView: View {
    
    private let viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Button {
            viewModel.didTapGoToSearch()
        } label: {
            Text("Go to Search")
        }
    }
}
