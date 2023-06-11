import UIKit

final class AppCoordinator {

    var navigationController: UINavigationController

    init(
        navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
    }

    func start() {
        let coordinator = UserSearchCoordinator(navigationController: navigationController)
        coordinator.start()
    }
}
