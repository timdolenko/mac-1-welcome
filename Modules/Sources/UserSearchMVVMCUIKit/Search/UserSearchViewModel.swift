import Foundation
import RxSwift
import RxCocoa
import DI
import UserSearchDomain

final class UserSearchViewModel {

    private var items = BehaviorSubject<[UserSearchCellViewModel]>(value: [])

    private var isShowingError = PublishSubject<Error>()

    private let showDetail = PublishSubject<UserSearchCellViewModel>()

    struct State {
        var items: Observable<[UserSearchCellViewModel]>
    }

    var state: State {
        State(
            items: items.asObservable()
        )
    }

    struct Effect {
        var showDetail: Observable<UserSearchCellViewModel>
        var isShowingError: Observable<Error>
    }

    var effect: Effect {
        Effect(
            showDetail: showDetail.asObservable(),
            isShowingError: isShowingError.asObservable()
        )
    }

    @Dependency
    private var repository: UserSearchRepository

    private let disposeBag = DisposeBag()

    init() {}

    func bind(
        searchText: Driver<String>,
        didSelectUser: Driver<UserSearchCellViewModel>
    ) {
        bindSearchText(searchText)

        didSelectUser
            .drive(showDetail)
            .disposed(by: disposeBag)
    }

    private func bindSearchText(_ searchText: Driver<String>) {
        let searchText = searchText
            .throttle(.milliseconds(500))

        searchText.filter { $0.isEmpty }
            .map { _ in [UserSearchCellViewModel]() }
            .drive(items)
            .disposed(by: disposeBag)

        let results = searchText
            .filter { !$0.isEmpty }
            .asObservable()
            .flatMapLatest(repository.performSearch)
            .share(replay: 1)

        results
            .compactMap { try? $0.get() }
            .map { $0.map { $0.toUserSearch } }
            .asDriver(onErrorJustReturn: [])
            .drive(items)
            .disposed(by: disposeBag)

        results
            .compactMap { $0.failure }
            .asDriver(onErrorRecover: { .just($0) })
            .drive(isShowingError)
            .disposed(by: disposeBag)
    }
}

extension User {
    var toUserSearch: UserSearchCellViewModel {
        UserSearchCellViewModel(name: name, profileImageUrl: profileImageUrl)
    }
}
