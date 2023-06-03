import SwiftUI
import Combine

// MARK: - UserAccountStating

protocol Model<State>: ObservableObject, AnyObject {
    associatedtype State

    var state: State { get }
}

struct UserAccountStyle {
    let padding: CGFloat = 16
    let dividerPadding: CGFloat = 16
}

struct UserAccountState {
    var isLoggedIn: Bool = false
    var username: String = ""
    var style: UserAccountStyle = UserAccountStyle()
    var supportEmailAddress: String = "email@address.com"
    let supportTelephoneNumber: String = "support@address.com"
    init() {}
}

protocol UserAccountViewModel: Model<UserAccountState> {
    func trackViewEvent()
    func didTapLogout()
    func didTapLogin()
}

// MARK: - UserAccountAction

final class UserAccountViewModelLive: UserAccountViewModel {

    @Published public private(set) var state: UserAccountState

    @Dependency
    private var auth: Authentication

    @Dependency
    private var tracking: Tracking

    public init(initialState: UserAccountState = UserAccountState()) {
        self.state = initialState

        NotificationCenter.default.addObserver(self, selector: #selector(userLoginStateChanged), name: .userLoginStateChanged, object: nil)

        readUserData()
    }

    public func trackViewEvent() {
        tracking.track("user_account")
    }

    public func didTapLogout() {
        Task {
            await auth.logout()
        }
    }

    public func didTapLogin() {
        Task {
            await auth.login()
        }
    }

    @objc
    private func userLoginStateChanged() {
        readUserData()
    }

    private func readUserData() {
        state.isLoggedIn = auth.isUserLoggedIn
        state.username = auth.email ?? ""
    }
}

struct UserProfileView<ViewModel: UserAccountViewModel>: View {

    @ObservedObject var viewModel: ViewModel

    private var state: UserAccountState { viewModel.state }
    private var style: UserAccountStyle { viewModel.state.style }

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    VStack(spacing: style.padding) {
                        // Login/Logout Section
                        if state.isLoggedIn {
                            Text(state.username)
                            Button("Logout", action: { viewModel.didTapLogout() })
                        } else {
                            Button("Login", action: { viewModel.didTapLogin() })
                        }
                    }
                    .padding(style.padding)

                    VStack(spacing: style.padding) {
                        // Mail Support Sub-Section
                        Text(state.supportEmailAddress)
                            .padding([.leading, .trailing], style.padding)

                        Divider()
                            .foregroundColor(Color.white)
                            .padding(.leading, style.dividerPadding)

                        // Telephone Support Sub-Section
                        Text(state.supportTelephoneNumber)
                            .padding([.leading, .trailing], style.padding)

                        Divider()
                            .foregroundColor(Color.black)
                            .padding(.leading, style.dividerPadding)
                            .padding(.bottom, style.padding)
                    }
                }
            }
        }
        .onAppear {
            viewModel.trackViewEvent()
        }
        .dynamicTypeSize(.medium)
    }
}
