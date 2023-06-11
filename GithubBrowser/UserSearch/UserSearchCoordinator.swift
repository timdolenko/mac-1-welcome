import Foundation
import UIKit
import SwiftUI

final class UserSearchCoordinator {

    private weak var navigationController: UINavigationController?

    private weak var userSearchVC: UIHostingController<UserSearchView>?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let userSearchView = UserSearchView()
        let vc = UIHostingController<UserSearchView>(rootView: userSearchView)
        navigationController?.pushViewController(vc, animated: false)
        userSearchVC = vc
    }
}
