import SwiftUI
import RxSwift
import UIKit
import Util

public class UserSearchCoordinator: Coordinator {

    private let navigationController: UINavigationController
    private let disposeBag = DisposeBag()

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let viewModel = UserSearchViewModel()
        viewModel.effect.showDetail.subscribe(onNext: {
            self.showDetail(with: $0)
        })
        .disposed(by: disposeBag)
        let controller = UserSearchVC.create(viewModel: viewModel)
        navigationController.pushViewController(controller, animated: false)
    }

    func showDetail(with user: UserSearchCellViewModel) {
        let coordinator = UserSearchDetailCoordinator(
            navigationController: navigationController
        )
        coordinator.start()
    }
}
