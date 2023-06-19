import UIKit
import UserSearchMVVMCUIKit
import UserSearchNetworking
import UserSearchNetworkingCore

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        RxSchedulerAssembly().assemble()
        NetworkAssembly().assemble()
        UserSearchNetworkAssembly().assemble()

        return true
    }

}
