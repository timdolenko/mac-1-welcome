import SwiftUI

extension MUI {
    public struct Title: View {
        private let text: String
        private let size: MUI.FontSize
        private let alignment: Alignment

        public init(
            _ text: String,
            fontSize: MUI.FontSize = .extraLarge,
            alignment: Alignment = .leading
        ) {
            self.text = text
            self.alignment = alignment
            self.size = fontSize
        }

        public var body: some View {
            Text(text)
                .foregroundColor(Color.white)
                .font(.system(size: fontSize, weight: .bold))
                .kerning(-0.24)
                .frame(maxWidth: .infinity, alignment: alignment)
        }

        private var fontSize: CGFloat {
            switch size {
            case .small:
                return 13
            case .medium:
                return 15
            case .large:
                return 19
            case .extraLarge:
                return 29
            }
        }
    }
}
