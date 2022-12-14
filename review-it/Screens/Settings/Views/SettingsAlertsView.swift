import SwiftUI

struct SettingsAlertsView: View {
    @EnvironmentObject private var settingsVM: SettingsScreenVM

    var body: some View {
        Text("Alerts are currently not available. Coming soon!")
            .padding(.macOS)
    }
}

struct SettingsAlertsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsAlertsView()
            .environmentObject(SettingsScreenVM())
    }
}
