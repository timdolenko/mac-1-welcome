import Foundation
import DI
import UserSearchDomain
import Util

public final class UserSearchNetworkAssembly: Assembly {

    public init() {}

    public func assemble() {
        Container.register(UserSearchRepository.self, UserSearchRepositoryLive())
    }
}
