import SwiftUI

struct RoundedButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.accentColor)
            .padding(.horizontal, 24)
            .padding(.vertical, 8)
            .background(Color.gray.opacity(0.1))
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .opacity(isEnabled ? 1 : 0.8)
            .saturation(isEnabled ? 1 : 0)
    }
}
