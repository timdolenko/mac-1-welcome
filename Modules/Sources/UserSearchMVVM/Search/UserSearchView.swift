import SwiftUI

public struct UserSearchView: View {

    @ObservedObject private var viewModel = UserSearchViewModel()

    public init() {}

    public var body: some View {
        NavigationStack {
            List(viewModel.users) { user in
                NavigationLink {
                    UserView()
                } label: {
                    rowView(user: user)
                }
            }
            .searchable(text: $viewModel.searchText, placement: .toolbar)
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
