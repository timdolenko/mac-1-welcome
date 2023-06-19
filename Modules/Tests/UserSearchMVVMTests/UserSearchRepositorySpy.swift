import Foundation
import UserSearchDomain

enum StubError: Error {
    case some
}

class UserSearchRepositorySpy: UserSearchRepository {

    var didSearch: [String] = []

    var mockResponse: [User] = [.stub]
    var shouldThrow: Bool = false

    func search(for name: String) async throws -> [UserSearchDomain.User] {
        didSearch.append(name)

        if shouldThrow {
            throw StubError.some
        }

        return mockResponse
    }
}
