import SwiftUI

final class AppReloadService: ObservableObject {
    @Published var reloadAppID = UUID()
    static let shared = AppReloadService()

    @MainActor
    func reloadApp() {
        reloadAppID = UUID()
    }
}
