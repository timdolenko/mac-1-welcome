//: [Previous](@previous)

import Foundation
import Combine

public struct UserData {}

public protocol SSOHandling: AnyObject {
    var isConfigured: Bool { get }
    var isUserLoggedIn: Bool { get }
    var jwt: String? { get }
    var cachedUserData: UserData? { get }
    func configure(with trackingId: String)
    func showLogin() throws
    func showUserRegistration() throws
    func ensureUserDataIsUpToDate(forceRefreshEndpointConfig: Bool, forceRefreshUserData: Bool) async throws -> UserData
    func refreshOrRequestUserDataWithRetry() async throws
    func clearCachedUserData()
    func logoutUser() async
    func fetchUserData() async throws -> UserData
}

class UserAccountViewModel {

    private let sso: SSOHandling

    init(sso: SSOHandling) {
        self.sso = sso
    }

    func showLogin() {
        do {
            try sso.showLogin()
        } catch {
            presentError(error)
        }
    }

    func showRegistration() {
        do {
            try sso.showUserRegistration()
        } catch {
            presentError(error)
        }
    }

    func presentError(_ error: Error) {}
}



//: [Next](@next)
