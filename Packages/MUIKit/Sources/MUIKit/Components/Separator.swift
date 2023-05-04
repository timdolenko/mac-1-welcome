import SwiftUI

extension MUI {
    public struct Separator: View {
        public init() {}
        public var body: some View {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
            }
            .edgesIgnoringSafeArea(.all)
            .frame(
                maxWidth: .infinity,
                maxHeight: 1
            )
            .padding(.horizontal, -16)
        }
    }
}

#if DEBUG
struct Separator_Previews: PreviewProvider {
    static var previews: some View {
        MUI.MultiplePreview {
            MUI.CustomStack {
                MUI.Separator()
            }
        }
    }
}
#endif
