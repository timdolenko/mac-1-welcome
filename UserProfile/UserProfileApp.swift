import SwiftUI

protocol Tracking {
    func track(_ event: String)
}

class TrackingLive: Tracking {
    func track(_ event: String) {
        print("didTrack")
    }
}

protocol Authentication {
    var isUserLoggedIn: Bool { get }
    var email: String? { get }
    func logout() async
    func login() async
}

class AuthenticationLive: Authentication {
    var isUserLoggedIn: Bool = true
    var email: String? = "mock@email.com"

    func logout() async {
        try? await Task.sleep(nanoseconds: 500000000)
        isUserLoggedIn = false
        await MainActor.run {
            NotificationCenter.default.post(name: .userLoginStateChanged, object: nil)
        }
    }

    func login() async {
        try? await Task.sleep(nanoseconds: 500000000)
        isUserLoggedIn = true
        await MainActor.run {
            NotificationCenter.default.post(name: .userLoginStateChanged, object: nil)
        }
    }
}

public extension Notification.Name {
    static let userLoginStateChanged = Notification.Name("UserLoginStateChanged")
}

@main
struct UserProfileApp: App {

    init() {
        Container.register(AuthenticationLive(), for: Authentication.self)
        Container.register(TrackingLive(), for: Tracking.self)
    }

    var body: some Scene {
        WindowGroup {
            UserProfileView(viewModel: UserAccountViewModelLive())
        }
    }
}
