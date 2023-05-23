//: [Previous](@previous)

import Foundation

public struct UserData {}

public protocol Authentication: AnyObject {
    var isConfigured: Bool { get }
    var isUserLoggedIn: Bool { get }
    var jwt: String? { get }
    func configure(with trackingId: String)
    func ensureUserDataIsUpToDate(
        forceRefreshEndpointConfig: Bool,
        forceRefreshUserData: Bool
    ) async throws -> UserData
    func logoutUser() async
}

public protocol AuthUserDataManager {
    var cachedUserData: UserData? { get }
    func fetchUserData() async throws -> UserData
    func refreshOrRequestUserDataWithRetry() async throws
    func clearCachedUserData()
}

//public class AuthenticationLive: Authentication, AuthUserDataManager, AuthPresenter {}
//
//public class AuthenticationLive: Authentication {}
//public class AuthUserDataManagerLive: AuthUserDataManager {}
//public class AuthPresenterLive: AuthPresenter {}
//
//public class Auth {
//    let authState: Authentication
//    let userData: UserDataManager
//    let presenter: AuthPresenter
//}

public protocol AuthPresenter: AnyObject {
    func showLogin()
    func showUserRegistration()
}

class UserAccountViewModel {

    private let auth: AuthPresenter

    init(auth: AuthPresenter) {
        self.auth = auth
    }

    func showLogin() {
        auth.showLogin()
    }

    func showRegistration() {
        auth.showUserRegistration()
    }
}

//: [Next](@next)
