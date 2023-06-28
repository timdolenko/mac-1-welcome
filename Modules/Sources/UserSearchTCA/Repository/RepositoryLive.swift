import Foundation
import Dependencies
import Networking
import UserSearchDomain
import UserSearchNetworking
import UserSearchNetworkingCore

extension UserSearchRepositoryTCA: DependencyKey {
    public static let liveValue = Self { query in
        @Dependency(\.transferService) var service
        let request = Endpoints.searchUsers(query: query)

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
