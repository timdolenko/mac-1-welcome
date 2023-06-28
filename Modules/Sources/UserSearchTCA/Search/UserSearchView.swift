import SwiftUI
import ComposableArchitecture

public struct UserSearchView: View {

    private let store: StoreOf<UserSearch>
    
    public init(store: StoreOf<UserSearch>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                List(viewStore.state.users) { user in
                    NavigationLink {
                        UserView()
                    } label: {
                        rowView(user: user)
                    }
                }
                .searchable(
                    text: viewStore.binding(
                        get: \.searchText,
                        send: UserSearch.Action.searchQueryChanged
                    ),
                    placement: .toolbar
                )
            }
            .alert(
                item: viewStore.binding(
                    get: { $0.errorAlert.map(ErrorAlert.init(title:)) },
                    send: .errorAlertDismissed
                ),
                content: { Alert(title: Text($0.title)) }
            )
        }
    }

    private func rowView(
        user: UserSearchCellViewModel
    ) -> some View {
        HStack {
            AsyncImage(url: user.profileImageUrl) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 44, height: 44)
            .clipShape(Circle())
            .padding(8)

            Text(user.name)
        }
    }
}

private struct ErrorAlert: Identifiable {
    var title: String
    var id: String { self.title }
}
