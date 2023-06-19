import UIKit
import Util
import UserSearchMVVMC

class AppCoordinator: Coordinator {

    private let navigationController: UINavigationController

    init(window: UIWindow) {
        navigationController = UINavigationController()
        window.rootViewController = navigationController
    }

    func start() {
        let coordinator = UserSearchCoordinator(
            navigationController: navigationController
        )

        coordinator.start()
    }
}
