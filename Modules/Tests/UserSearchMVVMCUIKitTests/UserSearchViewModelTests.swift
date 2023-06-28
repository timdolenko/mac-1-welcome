import XCTest
import RxSwift
import RxCocoa
import RxTest
import DI
import UserSearchDomain
import Mocks

@testable import UserSearchMVVMCUIKit

@MainActor
final class UserSearchViewModelTests: XCTestCase {

    private var sut: UserSearchViewModel!

    private var scheduler: TestScheduler!
    private var repository: UserSearchRepositorySpy!
    private var disposeBag: DisposeBag!
    private var searchText: PublishSubject<String?>!

    override func setUp() {
        searchText = PublishSubject<String?>()

        disposeBag = DisposeBag()

        scheduler = TestScheduler(initialClock: 0)
        repository = UserSearchRepositorySpy()

        Container.register(SchedulerType.self, scheduler)
        Container.register(UserSearchRepository.self, repository)

        sut = UserSearchViewModel()

        sut.bind(
            searchText: searchText.asObservable(),
            didSelectUser: .empty()
        )
    }

    func test_whenTextIsEntered_thenSearchIsPerformed() async throws {
        //when
        let query = "text"

        searchText.on(.next(query))

        let recorded = scheduler.createObserver([UserSearchCellViewModel].self)
        sut.state.items
            .bind(to: recorded)
            .disposed(by: disposeBag)

        scheduler.start()

        /// Task is needed because of UserSearchRepository+RxSwift.swift
        Task {
            //then
            XCTAssertEqual(repository.didSearch.count, 1)
            XCTAssertEqual(repository.didSearch, [query])

            XCTAssertEqual(recorded.events.count, 2)

            let event = recorded.events[1]

            let expectedValues = repository
                .mockResponse
                .map { $0.toUserSearch }

            XCTAssertEqual(event.value, .next(expectedValues))
        }
    }

    func test_whenTextQueryIsRemoved_thenSearchResultsAreRemoved() async {
        searchText.on(.next("text"))
        searchText.on(.next(""))

        let recorded = scheduler.createObserver([UserSearchCellViewModel].self)
        sut.state.items
            .bind(to: recorded)
            .disposed(by: disposeBag)

        scheduler.start()

        Task {
            XCTAssertEqual(recorded.events[1].value.element?.count, 1)
            XCTAssertEqual(recorded.events[2].value.element?.count, 0)
        }
    }

    func test_whenFailureIsReturned_thenErrorIsShown() async {
        repository.shouldThrow = true

        searchText.on(.next("text"))

        let items = scheduler
            .record(source: sut.state.items, disposeBag: disposeBag)
        let error = scheduler
            .record(source: sut.state.isShowingError, disposeBag: disposeBag)

        scheduler.start()

        //then
        XCTAssertEqual(items.events.count, 1)
        XCTAssertEqual(error.events[1].value.element, true)
    }
}

extension TestScheduler {
    func record<Source: ObservableConvertibleType>(source: Source, disposeBag: DisposeBag) -> TestableObserver<Source.Element> {
        let observer = self.createObserver(Source.Element.self)
        source.asObservable().bind(to: observer)
            .disposed(by: disposeBag)
        return observer
    }
}
