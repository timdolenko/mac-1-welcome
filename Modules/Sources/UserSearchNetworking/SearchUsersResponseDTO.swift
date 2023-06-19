import Foundation

public struct SearchUsersResponseDTO: Decodable {
    public struct Item: Decodable {
        enum CodingKeys: String, CodingKey {
            case login
            case id
            case avatarUrl = "avatar_url"
        }

        public let login: String
        public let id: Int
        public let avatarUrl: String
    }

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }

    public let totalCount: Int
    public let items: [Item]
}
