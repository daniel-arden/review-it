import SwiftUI

struct SettingsGeneralView: View {
    @EnvironmentObject private var settingsVM: SettingsScreenVM

    var body: some View {
        Text("General Screen")
    }
}

struct SettingsGeneralView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsGeneralView()
            .environmentObject(SettingsScreenVM())
    }
}
