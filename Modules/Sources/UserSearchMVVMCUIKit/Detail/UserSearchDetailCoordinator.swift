import SwiftUI
import UIKit
import Util

public class UserSearchDetailCoordinator: Coordinator {

    private let nav: UINavigationController

    public init(navigationController: UINavigationController) {
        nav = navigationController
    }

    public func start() {
        let detail = UserView()
        nav.pushViewController(UIHostingController(rootView: detail), animated: true)
    }
}
