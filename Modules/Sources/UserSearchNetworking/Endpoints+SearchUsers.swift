import Foundation
import Networking
import UserSearchNetworkingCore

public extension Endpoints {

    static func searchUsers(
        query: String,
        page: Int = 1,
        pageSize: Int = 30
    ) -> Endpoint<SearchUsersResponseDTO> {
        .init(
            path: "/search/users",
            method: .get,
            bodyParameters: nil,
            headers: [:],
            queryParameters: [
                "q": query,
                "per_page": pageSize.description,
                "page": page.description
            ]
        )
    }
}
