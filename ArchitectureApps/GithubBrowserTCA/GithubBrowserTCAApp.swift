import SwiftUI
import ComposableArchitecture
import UserSearchNetworking
import UserSearchNetworkingCore
import UserSearchTCA

@main
struct GithubBrowserTCAApp: App {
    var body: some Scene {
        WindowGroup {
            UserSearchView(store: Store(initialState: UserSearch.State()) {
                UserSearch()
            })
        }
    }

    init() {
        NetworkAssembly().assemble()
        UserSearchNetworkAssembly().assemble()
    }
}
