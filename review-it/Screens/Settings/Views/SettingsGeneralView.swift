import SwiftUI

struct SettingsGeneralView: View {
    @ObservedObject var userSettings = UserSettingsService.shared

    var body: some View {
        VStack(spacing: 16) {
            Toggle("Show controls and filters", isOn: userSettings.$reviewListControls)
            Toggle("Highlight unseen reviews", isOn: userSettings.$newReviewsHighlighted)
        }
        .padding(.macOS)
    }
}

struct SettingsGeneralView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsGeneralView()
    }
}
