import SwiftUI
import Util
import UserSearchMVVM
import UserSearchNetworking
import UserSearchNetworkingCore

@main
struct GithubBrowserMVVMApp: App {
    var body: some Scene {
        WindowGroup {
            UserSearchView()
        }
    }

    init() {
        SchedulerAssembly().assemble()
        NetworkAssembly().assemble()
        UserSearchNetworkAssembly().assemble()
    }
}
