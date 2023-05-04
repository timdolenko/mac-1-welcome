import SwiftUI

extension MUI {
    public enum ButtonSize {
        case regular
        case small
    }
}

extension MUI {
    public struct PrimaryButtonStyle: ButtonStyle {
        public init(disabled: Bool = false, isFullWidth: Bool = false, size: MUI.ButtonSize = .regular) {
            self.disabled = disabled
            self.isFullWidth = isFullWidth
            self.size = size
        }

        var disabled = false
        var isFullWidth = false
        var size: MUI.ButtonSize

        private let cornerRadius = 8.0

        public func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .frame(maxWidth: isFullWidth ? .infinity : nil)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .frame(minHeight: size == .regular ? 54 : nil)
                .background(backgroundColor(isTapped: configuration.isPressed))
                .cornerRadius(cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(
                            borderColor(isTapped: configuration.isPressed),
                            lineWidth: 1
                        )
                )
                .foregroundColor(textColor)
                .font(.system(size: 15, weight: .semibold))
                .animation(.easeIn(duration: 0.1), value: configuration.isPressed)

        }

        private func backgroundColor(isTapped: Bool) -> Color {
            if isTapped { return Color.black }
            return disabled ? Color.black : Color.blue
        }

        private func borderColor(isTapped: Bool) -> Color {
            if isTapped { return Color.black.opacity(0.5) }
            return disabled ? Color.black.opacity(0.5) : Color.blue
        }

        private var textColor: Color {
            return disabled ? Color.gray : Color.white
        }
    }
}

public extension MUI {
    struct PrimaryButton: View {
        private let text: String
        private let isDisabled: Bool
        private let action: () -> Void
        private let isFullWidth: Bool
        private let isLoading: Bool
        private let size: MUI.ButtonSize
        private let image: Image?

        public init(
            text: String,
            isDisabled: Bool,
            isFullWidth: Bool = false,
            isLoading: Bool = false,
            size: MUI.ButtonSize = .regular,
            image: Image? = nil,
            action: @escaping () -> Void
        ) {
            self.text = text
            self.isDisabled = isDisabled
            self.isFullWidth = isFullWidth
            self.isLoading = isLoading
            self.size = size
            self.image = image
            self.action = action
        }

        private var label: some View {
            HStack {
                image.opacity(isDisabled ? 0.3 : 1)
                Text(text)
            }
        }

        public var body: some View {
            Button(
                action: action,
                label: {
                    if isLoading {
                        ZStack {
                            label.hidden()
                            ProgressView()
                        }
                    } else {
                        label
                    }
                }
            )
            .buttonStyle(
                PrimaryButtonStyle(
                    disabled: isDisabled,
                    isFullWidth: isFullWidth,
                    size: size
                )
            )
            .disabled(isDisabled || isLoading)
        }
    }
}
