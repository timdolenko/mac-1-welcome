import Foundation
import SwiftUI

public enum CaptionTextType {
    case big
    case small

    var size: Int {
        switch self {
        case .big:
            return 13
        case .small:
            return 10
        }
    }
}

extension MUI {
    public struct CaptionText: View {
        private let text: String
        private let color: Color
        private let type: CaptionTextType
        private let weight: Font.Weight
        private let isFullWidth: Bool

        public init(
            text: String,
            color: Color = Color.white,
            type: CaptionTextType = .big,
            weight: Font.Weight = .medium,
            isFullWidth: Bool = true
        ) {
            self.text = text
            self.color = color
            self.type = type
            self.weight = weight
            self.isFullWidth = isFullWidth
        }

        public var body: some View {
            Text(text)
                .foregroundColor(color)
                .font(.system(
                    size: CGFloat(type.size),
                    weight: weight
                ))
                .frame(
                    maxWidth: isFullWidth ? .infinity : nil,
                    alignment: .leading
                )
        }
    }
}

struct CaptionText_Previews: PreviewProvider {
    static var previews: some View {
        MUI.MultiplePreview {
            MUI.CustomStack {
                MUI.CaptionText(text: "Caption text A")
                MUI.Separator()
                MUI.CaptionText(text: "Caption text B", isFullWidth: false)
                MUI.Separator()
                MUI.CaptionText(text: "Caption text C")
                MUI.Separator()
                MUI.CaptionText(
                    text: "Mock Text",
                    color: Color.blue,
                    type: .small
                )
            }
        }
    }
}
