import SwiftUI

struct MainScreen: View {
    @EnvironmentObject private var appReloadService: AppReloadService

    var body: some View {
        ReviewListScreen()
            .environment(
                \.managedObjectContext,
                 PersistenceController.shared.container.viewContext
            )
            .environmentObject(appReloadService)
            .id(appReloadService.reloadAppID)
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
