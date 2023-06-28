import Foundation

struct HomeViewModelActions {
    var goToSearch: () -> ()

    init(goToSearch: @escaping () -> Void) {
        self.goToSearch = goToSearch
    }
}

class HomeViewModel {

    private let actions: HomeViewModelActions

    init(actions: HomeViewModelActions) {
        self.actions = actions
    }

    func didTapGoToSearch() {
        actions.goToSearch()
    }
}
