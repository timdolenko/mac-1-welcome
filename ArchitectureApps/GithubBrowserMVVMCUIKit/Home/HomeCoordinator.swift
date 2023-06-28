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
