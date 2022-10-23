import SwiftUI

struct SettingsAccountView: View {
    @EnvironmentObject private var settingsVM: SettingsScreenVM

    var body: some View {
        VStack(spacing: 16) {
            loginButton

            Text("This feature is currently unavailable. Coming soon!")
        }
        .padding(.macOS)
    }
}

private extension SettingsAccountView {
    var loginButton: some View {
        Button {
            // TODO: Action
        } label: {
            HStack {
                Image(systemName: "person")
                    .resizable()
                    .padding()
                    .foregroundColor(.secondary)
                    .frame(width: 64, height: 64)
                    .background(Color.backgroundTertiary)
                    .clipShape(Circle())

                    Text("Tap to log in with App Store Connect")
            }
        }
        .disabled(true)
        #if os(macOS)
        .buttonStyle(RoundedButtonStyle(cornerRadius: 9))
        #endif
    }
}



struct SettingsAccountView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsAccountView()
            .environmentObject(SettingsScreenVM())
    }
}
