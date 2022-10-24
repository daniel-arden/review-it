import SwiftUI

struct SettingsGeneralView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var userSettings = UserSettingsService.shared
    @EnvironmentObject private var appReloadService: AppReloadService
    @State private var showResetConfirmationAlert = false

    var body: some View {
        VStack(spacing: 16) {
            Toggle("Show controls and filters", isOn: userSettings.$reviewListControls)
            Toggle("Highlight unseen reviews", isOn: userSettings.$newReviewsHighlighted)

            Button("Reset app data") {
                showResetConfirmationAlert.toggle()
            }
        }
        .alert(isPresented: $showResetConfirmationAlert) {
            Alert(
                title: Text("Reset app data"),
                message: Text("This action cannot be undone"),
                primaryButton: .destructive(Text("Reset")) {
                    withAnimation {
                        reset()
                        dismiss()
                    }
                },
                secondaryButton: .cancel()
            )
        }
        .padding(.macOS)
    }
}

private extension SettingsGeneralView {
    func reset() {
        do {
            try userSettings.reset()
        } catch {
            // TODO: Error handling
            fatalError(error.localizedDescription)
        }
        
        appReloadService.reloadApp()
    }
}

struct SettingsGeneralView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsGeneralView()
    }
}
