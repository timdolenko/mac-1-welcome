import SwiftUI

struct SetPasswordView: View {
    @ObservedObject var viewModel = SetPasswordViewModel()

    init() {}

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Text("Sign Up")
                    .foregroundColor(Color.white)
                    .font(.system(size: 29, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)

                Input(
                    "Enter your password",
                    text: $viewModel.password,
                    isPassword: true
                )

                Text("Password should contain:")
                    .foregroundColor(.gray)
                    .font(.system(
                        size: CGFloat(13),
                        weight: .medium
                    ))
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )

                FlowLayout(
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

                Button(
                    action: viewModel.didTapNext,
                    label: { Text("Next") }
                )
                .buttonStyle(
                    PrimaryButtonStyle(
                        disabled: !viewModel.isNextButtonEnabled,
                        isFullWidth: true
                    )
                )
                .disabled(!viewModel.isNextButtonEnabled)
            }
            .padding(16)
            .background(
                Color.black.edgesIgnoringSafeArea(.all)
            )
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
