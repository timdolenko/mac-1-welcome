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

    override func setUp() {
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)

        repository = UserSearchRepositorySpy()
        Container.register(UserSearchRepository.self, repository)

        sut = UserSearchViewModel()
    }

    func test_whenTextIsEntered_thenSearchIsPerformed() async throws {
        SharingScheduler.mock(scheduler: scheduler) {
            let queryStream = scheduler.createHotObservable([
                .next(300, "text")
            ]).asDriver(onErrorJustReturn: "")

            sut.bind(searchText: queryStream, didSelectUser: .empty())

            scheduler.start()

            /// Task is needed because of UserSearchRepository+RxSwift.swift
            Task {
                //then
                XCTAssertEqual(repository.didSearch.count, 1)
                XCTAssertEqual(repository.didSearch, ["text"])
            }
        }
    }

    func test_whenTextIsEntered_thenResultsAreDisplayed() async throws {
        SharingScheduler.mock(scheduler: scheduler) {
            let queryStream = scheduler.createHotObservable([
                .next(300, "text")
            ]).asDriver(onErrorJustReturn: "")

            let recorded = scheduler.record(
                source: sut.state.items.asObservable(),
                disposeBag: disposeBag
            )

            sut.bind(searchText: queryStream, didSelectUser: .empty())

            scheduler.start()

            Task {
                XCTAssertRecordedElements(recorded.events, [
                    [],
                    repository
                        .mockResponse
                        .map { $0.toUserSearch }
                ])
            }
        }
    }

    func test_whenTextQueryIsRemoved_thenSearchResultsAreRemoved() async {
        SharingScheduler.mock(scheduler: scheduler) {
            let queryStream = scheduler.createHotObservable([
                .next(300, "text"),
                .next(500, "")
            ]).asDriver(onErrorJustReturn: "")

            let recorded = scheduler.record(
                source: sut.state.items.asObservable(),
                disposeBag: disposeBag
            )

            sut.bind(searchText: queryStream, didSelectUser: .empty())

            scheduler.start()

            Task {
                XCTAssertRecordedElements(recorded.events, [
                    [],
                    repository
                        .mockResponse
                        .map { $0.toUserSearch },
                    []
                ])
            }
        }
    }

    func test_whenFailureIsReturned_thenErrorIsShown() async {
        SharingScheduler.mock(scheduler: scheduler) {
            repository.shouldThrow = true

            let queryStream = scheduler.createHotObservable([
                .next(300, "text")
            ]).asDriver(onErrorJustReturn: "")

            let recorded = scheduler.record(
                source: sut.state.items.asObservable(),
                disposeBag: disposeBag
            )

            let recordedError = scheduler.record(
                source: sut.effect.isShowingError.asObservable(),
                disposeBag: disposeBag
            )

            sut.bind(searchText: queryStream, didSelectUser: .empty())

            scheduler.start()

            Task {
                //then
                XCTAssertRecordedElements(recorded.events, [[]])
                XCTAssertEqual(recordedError.events.count, 1)
            }
        }
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
