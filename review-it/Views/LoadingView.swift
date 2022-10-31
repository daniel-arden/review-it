import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Spacer()

            ProgressView()
                .progressViewStyle(.circular)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
