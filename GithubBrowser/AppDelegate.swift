import UIKit

class Assembly {
    func assemble() {

    }
}

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    private var appCoordinator: AppCoordinator?
    internal var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Assembly().assemble()
        setupCoordinator()
        return true
    }

    private func setupCoordinator() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()

        window?.rootViewController = navigationController
        appCoordinator = AppCoordinator(
            navigationController: navigationController
        )
        appCoordinator?.start()
        window?.makeKeyAndVisible()
    }
}
