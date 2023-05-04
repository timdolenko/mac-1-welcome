import SwiftUI

extension MUI {
    public struct CustomStack<Content>: View where Content: View {
        private let view: Content
        private let padding: CGFloat

        public init(padding: CGFloat = 16, @ViewBuilder view: () -> Content) {
            self.padding = padding
            self.view = view()
        }

        public var body: some View {
            VStack(spacing: 16) {
                view
            }
            .padding(padding)
            .background(
                Color.black.edgesIgnoringSafeArea(.all)
            )
            .onTapGesture { self.hideKeyboard() }
        }

        private func hideKeyboard() {
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder),
                to: nil,
                from: nil,
                for: nil
            )
        }
    }
}
