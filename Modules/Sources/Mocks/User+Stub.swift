import UserSearchDomain
import Util

public extension User {
    static var stub: User {
        User(name: "mock", profileImageUrl: .stubImageUrl)
    }
}
