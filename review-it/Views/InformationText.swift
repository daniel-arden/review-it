import SwiftUI

struct InformationText: View {
    private let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .multilineTextAlignment(.center)
            .font(.callout)
            .foregroundColor(.secondary)
            .padding(.vertical)
    }
}
