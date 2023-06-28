import Foundation
import UserSearchDomain

public enum StubError: Error {
    case some
}

public class UserSearchRepositorySpy: UserSearchRepository {

    public init() {}

    public var didSearch: [String] = []

    public var mockResponse: [User] = [.stub]
    public var shouldThrow: Bool = false

    public func search(for name: String) async throws -> [UserSearchDomain.User] {
        didSearch.append(name)

        if shouldThrow {
            throw StubError.some
        }

        return mockResponse
    }
}
