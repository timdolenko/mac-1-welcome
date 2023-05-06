import SwiftUI

public struct Input: View {
    @Binding private var text: String
    private let placeholder: String
    private let isPassword: Bool
    private let onEditingChanged: (Bool) -> Void
    private let leftLabel: String?
    private let rightIcon: AnyView?

    @State private var revealPassword = false

    public init(
        _ placeholder: String,
        text: Binding<String>,
        isPassword: Bool = false,
        onEditingChanged: @escaping (Bool) -> Void = { _ in },
        leftLabel: String? = nil,
        rightIcon: AnyView? = nil
    ) {
        self.placeholder = placeholder
        self._text = text
        self.isPassword = isPassword
        self.onEditingChanged = onEditingChanged
        self.leftLabel = leftLabel
        self.rightIcon = rightIcon
    }

    public var body: some View {
        VStack(alignment: .leading) {
                HStack {
                    if let leftLabel = leftLabel {
                        Text(leftLabel)
                            .padding(.trailing)
                            .foregroundColor(Color.white.opacity(0.3))
                    }
                    inputComponent
                    if isPassword {
                        revealPasswordButton
                    }
                    rightIcon
                }
                .font(.system(size: 15))
                .padding(.vertical, 16)
                .padding(.horizontal, 10)
                .frame(minHeight: 54)
                .background(Color.black)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(
                            strokeColor,
                            style: StrokeStyle(lineWidth: 1))
                )
                .foregroundColor(textColor)
                .autocapitalization(.none)
                .autocorrectionDisabled(true)
        }
    }

    private var revealPasswordButton: some View {
        Button(
            action: { revealPassword.toggle() },
            label: {
                Group {
                    if revealPassword {
                        Image("eyeOpen")
                            .resizable()
                    } else {
                        Image("eyeClosed")
                            .resizable()
                    }
                }
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.blue)
                .frame(width: 30, height: 30)
            }
        )
    }

    private var textField: some View {
        TextField(
            placeholder,
            text: $text,
            onEditingChanged: onEditingChanged
        )
    }

    private var secureField: some View {
        SecureField(placeholder, text: $text)
    }

    private var inputComponent: some View {
        if revealPassword {
            return AnyView(textField)
        } else if isPassword {
            return AnyView(secureField)
        } else {
            return AnyView(textField)
        }
    }

    private var strokeColor: Color { .white }

    private var textColor: Color { .white }
}
