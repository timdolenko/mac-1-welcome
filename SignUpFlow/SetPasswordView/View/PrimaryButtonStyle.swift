import Foundation
import SwiftUI

public struct PrimaryButtonStyle: ButtonStyle {
    public init(disabled: Bool = false, isFullWidth: Bool = false, size: ButtonSize = .regular) {
        self.disabled = disabled
        self.isFullWidth = isFullWidth
        self.size = size
    }

    var disabled = false
    var isFullWidth = false
    var size: ButtonSize

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

public enum ButtonSize {
    case regular
    case small
}
