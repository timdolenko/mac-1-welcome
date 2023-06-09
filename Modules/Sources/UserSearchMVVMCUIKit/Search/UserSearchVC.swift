import UIKit
import RxCocoa
import RxSwift
import DI
import Util
import UserSearchDomain

public final class UserSearchVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    private var viewModel: UserSearchViewModel!

    var coordinator: Coordinator!

    private let disposeBag = DisposeBag()

    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UserSearchCell.self)

        viewModel.bind(
            searchText: searchBar.rx.text
                .compactMap { $0 }
                .asDriver(onErrorJustReturn: ""),
            didSelectUser: tableView.rx.modelSelected(UserSearchCellViewModel.self)
                .asDriver()
        )

        viewModel.state.items
            .bind(to: tableView.rx.items(
                cellIdentifier: UserSearchCell.identifier,
                cellType: UserSearchCell.self)
            ) { _, element, cell in
                cell.setContent(element)
            }
            .disposed(by: disposeBag)
    }
}

extension UserSearchVC {
    static func create(viewModel: UserSearchViewModel) -> UserSearchVC {
        let controller = UIStoryboard(
            name: "UserSearchVC",
            bundle: .module
        ).instantiateInitialViewController() as! UserSearchVC
        controller.viewModel = viewModel
        return controller
    }
}

extension UITableView {
    func register<Cell: Identifiable>(_ type: Cell.Type) {
        register(UINib(
            nibName: type.identifier,
            bundle: .module
        ), forCellReuseIdentifier: type.identifier)
    }
}
