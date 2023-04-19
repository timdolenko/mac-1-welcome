import Foundation

struct UserStatus {
    let isPremium: Bool
}

class Router {
    static var shared = Router()

    func route(to destination: String) {
        print("routing to \(destination)...")
    }
}

class AuthHandler {

    private let networkService = NetworkServiceMock()

    func didCompleteLogin(with userStatus: UserStatus) {
        networkService.request()

        if userStatus.isPremium {
            Router.shared.route(to: "premium-welcome")
        }
    }

}
