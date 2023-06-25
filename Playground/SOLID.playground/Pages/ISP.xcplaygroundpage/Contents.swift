//: [Previous](@previous)

import Foundation

public struct UserData {}

public protocol Authentication: AnyObject {
    var isConfigured: Bool { get }
    var isUserLoggedIn: Bool { get }
    var jwt: String? { get }
    var cachedUserData: UserData? { get }
    func configure(with trackingId: String)
    func showLogin()
    func showUserRegistration()
    func ensureUserDataIsUpToDate(
        forceRefreshEndpointConfig: Bool,
        forceRefreshUserData: Bool
    ) async throws -> UserData
    func refreshOrRequestUserDataWithRetry() async throws
    func clearCachedUserData()
    func logoutUser() async
    func fetchUserData() async throws -> UserData
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
