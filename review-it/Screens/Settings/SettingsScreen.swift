import SwiftUI

struct SettingsScreen: View {
    @StateObject private var settingsVM = SettingsScreenVM()

    var body: some View { content }
}

#if os(iOS)
private extension SettingsScreen {
    var content: some View {
        List {
            ForEach(SettingsType.allCases) { settingType in
                Section(settingType.rawValue.capitalized) {
                    settingType.view
                }
                .environmentObject(settingsVM)
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
    }
}
#elseif os(macOS)
private extension SettingsScreen {
    var content: some View {
        TabView {
            ForEach(SettingsType.allCases) { settingType in
                settingType.view
                    .environmentObject(settingsVM)
                    .tabItem {
                        Label(
                            settingType.rawValue.capitalized,
                            systemImage: settingType.iconSystemName
                        )
                    }
            }
        }
        .frame(minWidth: 400)
    }
}
#endif

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen()
    }
}
