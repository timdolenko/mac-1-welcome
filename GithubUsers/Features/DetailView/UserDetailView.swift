import SwiftUI

struct UserDetailView: View {

    var viewModel: UserDetailViewModel

    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                AsyncImage(url: URL(string: viewModel.profilePictureURL)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                             .aspectRatio(contentMode: .fit)
                    case .failure:
                        Image(systemName: "photo")
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 120, height: 120)
                .cornerRadius(8)

                Text(viewModel.username)
                Text(viewModel.publicRepositories)
                    .padding(.bottom)
                Text(viewModel.bio)

                Spacer()
            }
        }
        .navigationTitle(viewModel.username)
    }
}
