import XCTest
import CombineSchedulers
import DI
import UserSearchDomain

@testable import UserSearchMVVM

final class UserSearchViewModelTests: XCTestCase {

    private var sut: UserSearchViewModel!

    private var scheduler: TestSchedulerOf<DispatchQueue>!
    private var repository: UserSearchRepositorySpy!

    override func setUp() {
        scheduler = DispatchQueue.test
        repository = UserSearchRepositorySpy()

        Container.register(AnySchedulerOf<DispatchQueue>.self, scheduler.eraseToAnyScheduler)
        Container.register(UserSearchRepository.self, repository)

        sut = UserSearchViewModel()
    }

    func test_whenTextIsEntered_thenSearchIsPerformed() async {
        //when
        let query = "text"
        sut.searchText = query
        await scheduler.advance(by: 1)

        //then
        XCTAssertEqual(repository.didSearch.count, 1)
        XCTAssertEqual(repository.didSearch, [query])

        XCTAssertEqual(sut.users[0].name, repository.mockResponse[0].name)
        XCTAssertEqual(sut.users[0].profileImageUrl, repository.mockResponse[0].profileImageUrl)
    }

    func test_whenTextQueryIsRemoved_thenSearchResultsAreRemoved() async {
        sut.searchText = "text"
        await scheduler.advance(by: 1)

        XCTAssertEqual(sut.users.count, 1)

        sut.searchText = ""
        await scheduler.advance(by: 1)
        XCTAssertEqual(sut.users.count, 0)
    }

    func test_whenFailureIsReturned_thenErrorIsShown() async {
        sut.searchText = "text"
        repository.shouldThrow = true
        await scheduler.advance(by: 1)

        //then
        XCTAssertEqual(sut.users.count, 0)
        XCTAssertEqual(sut.isErrorAlertShown, true)
    }
}
