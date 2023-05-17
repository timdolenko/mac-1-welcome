import Foundation

struct UserStatus {
    let isPremium: Bool
}

class Router: RouterProtocol {
    static var shared = Router()

    func route(to destination: String) {
        print("routing to \(destination)...")
    }
}

protocol RouterProtocol {
    func route(to destination: String)
}

var auth = AuthHandler(networkService: NetworkServiceMock(), routerService: Router.shared)

class AuthHandler {

//    private let networkService = NetworkServiceMock()
    var networkService: NetworkServiceProtocol
    var routerService: RouterProtocol

    init(networkService: NetworkServiceProtocol, routerService: RouterProtocol) {
        self.networkService = networkService
        self.routerService = routerService
    }

    func didCompleteLogin(with userStatus: UserStatus) {
        networkService.request()

        if userStatus.isPremium {
            routerService.route(to: "premium-welcome")
//            Router.shared.route(to: "premium-welcome")
        }
    }

}
