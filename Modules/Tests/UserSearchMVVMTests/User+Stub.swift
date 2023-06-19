import UserSearchDomain

extension User {
    static var stub: User {
        User(name: "mock", profileImageUrl: .stubImageUrl)
    }
}
