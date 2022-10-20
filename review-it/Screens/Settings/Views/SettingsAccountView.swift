import SwiftUI

struct SettingsAccountView: View {
    @EnvironmentObject private var settingsVM: SettingsScreenVM

    var body: some View {
        Text("Account Screen")
    }
}

struct SettingsAccountView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsAccountView()
            .environmentObject(SettingsScreenVM())
    }
}
