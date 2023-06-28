import Foundation
import UserSearchDomain

public struct UserSearchCellViewModel: Identifiable, Equatable {
    public let id: UUID = UUID()
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

public extension User {
    var toUserSearch: UserSearchCellViewModel {
        UserSearchCellViewModel(name: name, profileImageUrl: profileImageUrl)
    }
}
