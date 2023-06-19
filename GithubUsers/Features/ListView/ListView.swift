import SwiftUI

struct ListView: View {

    @ObservedObject var viewModel: UserListViewModel

    var body: some View {
        NavigationStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)

            List(viewModel.users) { user in
                NavigationLink(user.login, value: user)
            }
            .cornerRadius(8)
            .navigationDestination(for: User.self) { user in
                UserDetailView(viewModel: viewModel.detailViewModel(for: user))
            }
            .padding()
        }
    }
}
