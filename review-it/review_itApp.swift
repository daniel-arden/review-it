import SwiftUI

@main
struct review_itApp: App {
    var body: some Scene {
        WindowGroup {
            ReviewListScreen()
                .environment(
                    \.managedObjectContext,
                     PersistenceController.shared.container.viewContext
                )
        }

        #if os(macOS)
        Settings {
            SettingsScreen()
        }
        #endif
    }
}
