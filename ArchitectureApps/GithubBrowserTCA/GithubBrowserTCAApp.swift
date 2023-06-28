import SwiftUI
import ComposableArchitecture
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
}
