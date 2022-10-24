import SwiftUI

@main
struct review_itApp: App {
    @StateObject private var appReloadService = AppReloadService()

    var body: some Scene {
        WindowGroup {
            MainScreen()
                .environmentObject(appReloadService)
        }
        .applyCommands()

        #if os(macOS)
        Settings {
            SettingsScreen()
                .environmentObject(appReloadService)
        }
        #endif
    }
}

private extension Scene {
    @SceneBuilder
    func applyCommands() -> some Scene {
        #if os(macOS)
        self.commands {
            CommandGroup(replacing: .appInfo) {
                Button("About ReviewIT") {
                    NSApplication.shared.orderFrontStandardAboutPanel(
                        options: [
                            NSApplication.AboutPanelOptionKey.credits: NSAttributedString(
                                string: "Some custom info about my app.",
                                attributes: [
                                    NSAttributedString.Key.font: NSFont.boldSystemFont(
                                        ofSize: NSFont.smallSystemFontSize)
                                ]
                            ),
                            NSApplication.AboutPanelOptionKey(
                                rawValue: "Copyright"
                            ): "© 2022 Daniel Arden"
                        ]
                    )
                }
            }
        }
        #else
        self
        #endif
    }
}
