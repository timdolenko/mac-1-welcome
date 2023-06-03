import UIKit

class Assembly {
    func assemble() {

    }
}

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    private var rootRouter: Router?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        Assembly().assemble()

        rootRouter = RootRouter()
        rootRouter?.start()
        return true
    }
}
