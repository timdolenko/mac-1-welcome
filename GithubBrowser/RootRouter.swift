import UIKit

final class RootRouter: Router {

    private lazy var window = UIWindow(frame: UIScreen.main.bounds)
    private lazy var rootVC = UIViewController()
    private var cancelbag = CancelBag()

    override func start() {
        super.start()
        window.rootViewController = rootVC
        window.makeKeyAndVisible()

        routeHome()
    }

    private func routeHome() {
        let sessionCoordinator = HomeViewCoordinator(container: container, parent: rootVC)
        sessionCoordinator.endUserSession
            .first()
            .sink { [weak self] _ in
                self?.coordinateToLogIn()
            }
            .store(in: &cancelbag)
        coordinate(to: sessionCoordinator)
    }
}
