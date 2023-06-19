import Foundation
import Networking
import DI
import UserSearchDomain
import UserSearchNetworkingCore

public final class UserSearchRepositoryLive: UserSearchRepository {

    @Dependency
    private var service: DataTransferService

    public func search(for name: String) async throws -> [User] {
        let request = Endpoints.searchUsers(query: name)

        return try await withCheckedThrowingContinuation { continuation in
            service.request(with: request) { result in
                continuation.resume(
                    with: result
                        .map { $0.items.compactMap { $0.toDomain } }
                )
            }
        }
    }
}

fileprivate extension SearchUsersResponseDTO.Item {
    var toDomain: User? {
        guard let url = URL(string: avatarUrl) else { return nil }
        return User(name: login, profileImageUrl: url)
    }
}
