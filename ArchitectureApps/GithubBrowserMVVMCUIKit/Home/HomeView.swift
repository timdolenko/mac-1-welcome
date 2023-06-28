import Foundation
import SwiftUI
import UserSearchMVVMCUIKit
import Util

struct HomeView: View {
    
    private let viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Button {
            viewModel.didTapGoToSearch()
        } label: {
            Text("Go to Search")
        }
    }
}
