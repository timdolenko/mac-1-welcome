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
        viewModel.effect.showDetail.subscribe(onNext: { [weak self] in
            self?.showDetail(with: $0)
        })
        .disposed(by: disposeBag)
        let controller = UserSearchVC.create(viewModel: viewModel)
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }

    func showDetail(with user: UserSearchCellViewModel) {
        let coordinator = UserSearchDetailCoordinator(
            navigationController: navigationController
        )
        coordinator.start()
    }
}
