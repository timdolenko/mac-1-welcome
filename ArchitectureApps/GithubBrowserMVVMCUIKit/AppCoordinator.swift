import UIKit
import Util
import UserSearchMVVMCUIKit

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
