import ComposableArchitecture
import XCTest
import DI
import Mocks
import UserSearchDomain

@testable import UserSearchTCA

@MainActor
final class UserSearchTests: XCTestCase {

    let store = TestStore(initialState: UserSearch.State()) {
        UserSearch()
    } withDependencies: {
        $0.uuid = .incrementing
        $0.userSearchRepository.search = { query in
            return [User.stub]
        }
    }

    private var mockUsers: [UserSearchCellViewModel] {
        withDependencies {
            $0.uuid = .incrementing
        } operation: {
            return [User.stub]
                .map { $0.toUserSearch }
        }
    }

    func test_whenUserTypesAQuery_thenSearchIsPerformed() async {
        await store.send(.searchQueryChanged("text")) {
            $0.searchText = "text"
        }
        await store.receive(.usersFound(mockUsers)) {
            $0.users = self.mockUsers
        }
    }

    func test_whenUserTypesAnEmptyQuery_thenResultsAreCleared() async {
        await store.send(.searchQueryChanged("text")) {
            $0.searchText = "text"
        }
        await store.receive(.usersFound(mockUsers)) {
            $0.users = self.mockUsers
        }
        await store.send(.searchQueryChanged("")) {
            $0.searchText = ""
            $0.users = []
        }
    }

    func test_whenRepositoryFails_thenErrorIsDisplayed() async {
        let store = TestStore(initialState: UserSearch.State()) {
            UserSearch()
        } withDependencies: {
            $0.uuid = .incrementing
            $0.userSearchRepository.search = { query in
                throw MockError.stub
            }
        }

        await store.send(.searchQueryChanged("text")) {
            $0.searchText = "text"
        }
        await store.receive(
            .networkFailure(MockError.stub.localizedDescription)
        ) {
            $0.errorAlert = MockError.stub.localizedDescription
        }
    }
}

enum MockError: Error { case stub }
