import SwiftUI
import MUIKit

struct SetPasswordSolutionView: View {
    @ObservedObject var viewModel = SetPasswordSolutionViewModel(
        validator: PasswordValidatorSolutionLive()
    )

    init() {}

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
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
                                    ? Color.white
                                    : Color.gray
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
            .padding(16)
            .background(
                Color.black.edgesIgnoringSafeArea(.all)
            )
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
