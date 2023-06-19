import UIKit
import SwiftUI
import Util

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var rootCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setupNavigation(with: scene)
    }

    private func setupNavigation(with scene: UIScene) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        rootCoordinator = AppCoordinator(window: window)
        rootCoordinator?.start()
        self.window = window
        window.makeKeyAndVisible()
    }
}
