import Foundation
import Combine
import DI
import Util
import UserSearchDomain
import CombineSchedulers

final class UserSearchViewModel: ObservableObject {

    @Published var searchText: String = ""
    @Published var users: [UserSearchCellViewModel] = []
    @Published var isErrorAlertShown: Bool = false

    @Dependency
    private var repository: UserSearchRepository

    @Dependency
    private var scheduler: AnySchedulerOf<DispatchQueue>

    init() {
        bindSearch()
    }

    private func bindSearch() {
        let searchText = $searchText
            .debounce(for: 0.3, scheduler: scheduler)
            .share()

        let result = searchText
            .filter { !$0.isEmpty }
            .flatMap(repository.performSearch)
            .map { $0.map { $0.map { $0.toUserSearch } } }
            .receive(on: scheduler)
            .share()

        result
            .compactMap { try? $0.get() }
            .assign(to: &$users)

        result
            .compactMap { $0.failure }
            .map { _ in true }
            .assign(to: &$isErrorAlertShown)

        searchText
            .filter { $0.isEmpty }
            .map { _ in [UserSearchCellViewModel]() }
            .assign(to: &$users)
    }
}


