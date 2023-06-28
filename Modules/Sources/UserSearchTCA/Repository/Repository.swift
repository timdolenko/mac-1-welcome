import UserSearchDomain
import Dependencies

public struct UserSearchRepositoryTCA {
    public init(
        search: @escaping (String) async throws -> [User]
    ) {
        self.search = search
    }

    public var search: (String) async throws -> [User]
}

extension DependencyValues {
    public var userSearchRepository: UserSearchRepositoryTCA {
        get { self[UserSearchRepositoryTCA.self] }
        set { self[UserSearchRepositoryTCA.self] = newValue }
    }
}
