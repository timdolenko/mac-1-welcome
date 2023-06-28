import Foundation
import Dependencies
import UserSearchDomain

public struct UserSearchCellViewModel: Identifiable, Equatable {
    public let id: UUID

    init(name: String, profileImageUrl: URL) {
        @Dependency(\.uuid) var uuid
        self.id = uuid()

        self.name = name
        self.profileImageUrl = profileImageUrl
    }

    public let name: String
    public let profileImageUrl: URL
}

extension Array where Element == UserSearchCellViewModel {
    static var preview: [UserSearchCellViewModel] {
        [
            .init(name: "Bob", profileImageUrl: .stubImageUrl),
            .init(name: "Mike", profileImageUrl: .stubImageUrl),
            .init(name: "Alex", profileImageUrl: .stubImageUrl)
        ]
    }
}
