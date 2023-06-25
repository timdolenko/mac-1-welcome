//: [Previous](@previous)

import Foundation

import Foundation

public struct UserData {}

public protocol AuthPresenter {
    func showLogin()
    func showUserRegistration()
}

public protocol UserDataManager {
    var cachedUserData: UserData? { get }
    func clearCachedUserData()
    func fetchUserData() async throws -> UserData
}

public protocol Authentication: AnyObject {
    var isConfigured: Bool { get }
    var isUserLoggedIn: Bool { get }
    var jwt: String? { get }
    func configure(with trackingId: String)
    func ensureUserDataIsUpToDate(
        forceRefreshEndpointConfig: Bool,
        forceRefreshUserData: Bool
    ) async throws -> UserData
    func refreshOrRequestUserDataWithRetry() async throws
    func logoutUser() async
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
