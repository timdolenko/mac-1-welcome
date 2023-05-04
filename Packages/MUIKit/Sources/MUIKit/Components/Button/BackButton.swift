import SwiftUI

extension MUI {
    public struct BackButton: View {
        private let action: () -> Void

        public init(action: @escaping () -> Void) {
            self.action = action
        }

        public var body: some View {
            HStack {
                Button(
                    action: action,
                    label: {
                        Image(systemName: "chevron.backward")
                        Text("Back")
                    }
                )
            }.foregroundColor(Color.blue)
        }
    }
}
