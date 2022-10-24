import SwiftUI

final class UserSettingsService: ObservableObject {
    static let shared = UserSettingsService()

    @AppStorage(UserDefaults.Key.selectedAppId) var selectedAppId: Int?
    @AppStorage(UserDefaults.Key.reviewListControls) var reviewListControls = true
    @AppStorage(UserDefaults.Key.newReviewsHighlighted) var newReviewsHighlighted = true
}

extension UserSettingsService {
    @MainActor
    func reset() throws {
        reviewListControls = true
        newReviewsHighlighted = true
        selectedAppId = nil
        try PersistenceController.shared.reset()
    }
}
