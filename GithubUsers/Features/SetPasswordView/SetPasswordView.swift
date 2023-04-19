import SwiftUI
import MUIKit

struct SetPasswordView: View {
    @ObservedObject var viewModel: SetPasswordViewModel

    init(viewModel: SetPasswordViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }

    private var backButton: some View {
        MUI.BackButton(action: viewModel.didTapBack)
    }

    var body: some View {
        NavigationView {
            MUI.CustomStack {
                MUI.Title("Sign Up")
                MUI.Separator()
                MUI.Input(
                    "Enter your password",
                    text: $viewModel.password,
                    isPassword: true
                )

                MUI.CaptionText(
                    text: "Password should contain:",
                    color: Color.gray
                )

                MUI.FlowLayout(
                    items: viewModel.items
                ) {
                    Text($0.text)
                        .font(.system(size: 15))
                        .foregroundColor(
                            $0.isSelected
                                ? Color.white
                                : Color.gray
                        )
                        .padding(.vertical, 4)
                        .padding(.horizontal, 10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(
                                    $0.isSelected
                                    ? Color.gray
                                    : Color.black
                                )
                        )
                }

                Spacer()

                MUI.PrimaryButton(
                    text: "Next",
                    isDisabled: !viewModel.isNextButtonEnabled,
                    isFullWidth: true,
                    action: viewModel.didTapNext
                )
            }
            .navigationBarItems(leading: backButton)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SetPasswordViewBody_Previews: PreviewProvider {
    static var previews: some View {
        SetPasswordView(
            viewModel: SetPasswordViewModel(validator: PasswordValidatorLive())
        )
    }
}
