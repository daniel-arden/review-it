import SwiftUI

final class AppReloadService: ObservableObject {
    @Published var reloadAppID = UUID()

    @MainActor
    func reloadApp() {
        reloadAppID = UUID()
    }
}

