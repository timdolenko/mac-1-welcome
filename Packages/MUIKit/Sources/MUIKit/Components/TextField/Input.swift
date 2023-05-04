import SwiftUI

extension MUI {
    public enum MaskType: String {
        case phone = "(###) ###-####"
    }

    public struct Input: View {
        @Binding private var text: String
        private let placeholder: String
        private let errorMessage: String?
        private let isPassword: Bool
        private let onEditingChanged: (Bool) -> Void
        private let leftLabel: String?
        private let rightIcon: AnyView?
        private let maskType: MaskType?

        @State private var revealPassword = false

        public init(
            _ placeholder: String,
            text: Binding<String>,
            errorMessage: String? = nil,
            isPassword: Bool = false,
            onEditingChanged: @escaping (Bool) -> Void = { _ in },
            leftLabel: String? = nil,
            rightIcon: AnyView? = nil,
            maskType: MaskType? = nil
        ) {
            self.placeholder = placeholder
            self._text = text
            self.errorMessage = errorMessage
            self.isPassword = isPassword
            self.onEditingChanged = onEditingChanged
            self.leftLabel = leftLabel
            self.maskType = maskType
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
                if let errorMessage = errorMessage {
                    MUI.CaptionText(
                        text: errorMessage,
                        color: strokeColor
                    )
                }
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
                    .frame(width: 21, height: 21)
                }
            )
        }

        private var textField: some View {
            TextField(
                placeholder,
                text: $text,
                onEditingChanged: onEditingChanged
            )
            .onChange(of: text, perform: { newValue in
                if let mask = maskType?.rawValue {
                    self.text = applyMask(mask, to: newValue)
                }
            })
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

        private var strokeColor: Color {
            if isError {
                return Color.blue
            } else {
                return Color.gray
            }
        }

        private var textColor: Color {
            if isError {
                return Color.red
            } else {
                return .white
            }
        }

        private var isError: Bool {
            errorMessage != nil
        }

        public func applyMask(_ mask: String, to value: String) -> String {
            let cleanPhoneNumber = value.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            var result = ""
            var index = cleanPhoneNumber.startIndex
            for ch in mask where index < cleanPhoneNumber.endIndex {
                if ch == "#" {
                    result.append(cleanPhoneNumber[index])
                    index = cleanPhoneNumber.index(after: index)
                } else {
                    result.append(ch)
                }
            }
            return result
        }
    }
}
