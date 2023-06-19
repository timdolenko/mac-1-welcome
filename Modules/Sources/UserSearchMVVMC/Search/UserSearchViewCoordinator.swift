import SwiftUI
import UIKit
import Util

public class UserSearchCoordinator: Coordinator {

    private let nav: UINavigationController

    public init(navigationController: UINavigationController) {
        nav = navigationController
    }

    public func start() {
        let actions = UserSearchViewModelActions(showDetail: showDetail(with:))
        let viewModel = UserSearchViewModel(actions: actions)
        let searchView = UserSearchView(viewModel: viewModel)
        let hosting = UIHostingController(rootView: searchView)
        nav.pushViewController(hosting, animated: false)
    }

    func showDetail(with user: UserSearchCellViewModel) {
        let coordinator = UserSearchDetailCoordinator(navigationController: nav)
        coordinator.start()
    }
}
