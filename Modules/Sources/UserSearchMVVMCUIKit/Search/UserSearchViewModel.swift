import Foundation
import RxSwift
import RxCocoa
import DI
import UserSearchDomain

final class UserSearchViewModel {

    private var items = BehaviorSubject<[UserSearchCellViewModel]>(value: [])

    private var isShowingError = BehaviorSubject<Bool>(value: false)

    private let showDetail = PublishSubject<UserSearchCellViewModel>()

    struct State {
        var items: Observable<[UserSearchCellViewModel]>
        var isShowingError: Observable<Bool>
    }

    var state: State {
        State(
            items: items.asObservable(),
            isShowingError: isShowingError.asObservable()
        )
    }

    struct Effect {
        var showDetail: Observable<UserSearchCellViewModel>
    }

    var effect: Effect {
        Effect(showDetail: showDetail.asObservable())
    }

    @Dependency
    private var scheduler: SchedulerType

    @Dependency
    private var repository: UserSearchRepository

    private let disposeBag = DisposeBag()

    init() {}

    func bind(
        searchText: Observable<String?>,
        didSelectUser: Observable<UserSearchCellViewModel>
    ) {
        bindSearchText(searchText)

        didSelectUser
            .bind(to: showDetail)
            .disposed(by: disposeBag)
    }

    private func bindSearchText(_ searchText: Observable<String?>) {
        let searchText = searchText
            .throttle(.milliseconds(300), scheduler: scheduler)
            .compactMap { $0 }

        searchText.filter { $0.isEmpty }
            .map { _ in [UserSearchCellViewModel]() }
            .bind(to: items)
            .disposed(by: disposeBag)

        let results = searchText.filter { !$0.isEmpty }
            .flatMapLatest(repository.performSearch)
            .share(replay: 1)

        results
            .compactMap { try? $0.get() }
            .map { $0.map { $0.toUserSearch } }
            .bind(to: items)
            .disposed(by: disposeBag)

        results
            .map { $0.isFailure }
            .bind(to: isShowingError)
            .disposed(by: disposeBag)
    }
}

extension User {
    var toUserSearch: UserSearchCellViewModel {
        UserSearchCellViewModel(name: name, profileImageUrl: profileImageUrl)
    }
}
