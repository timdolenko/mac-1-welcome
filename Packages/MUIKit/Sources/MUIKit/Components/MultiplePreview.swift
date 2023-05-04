import SwiftUI

extension MUI {
    public struct MultiplePreview<Content>: View where Content: View {
        private let views: Content
        private let title: String

        public init(_ title: String = "", @ViewBuilder views: () -> Content) {
            self.views = views()
            self.title = title
        }

        public var body: some View {
            views
                .previewDevice("iPhone SE (3rd generation)")
                .previewDisplayName("\(prefix())iPhone SE")
                .preferredColorScheme(.dark)
            views
                .previewDevice("iPhone 8")
                .previewDisplayName("\(prefix())iPhone 8")
                .preferredColorScheme(.dark)
            views
                .previewDevice("iPhone 14")
                .previewDisplayName("\(prefix())iPhone 14")
                .preferredColorScheme(.dark)
        }

        private func prefix() -> String {
            if title.isEmpty {
                return ""
            } else {
                return "\(title) - "
            }
        }
    }
}

struct MultiplePreview_Previews: PreviewProvider {
    static var previews: some View {
        MUI.MultiplePreview {
            Text("MUIKit")
        }
    }
}
