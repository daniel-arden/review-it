import SwiftUI

final class UserSettingsService: ObservableObject {
    static let shared = UserSettingsService()

    @AppStorage(UserDefaults.Key.reviewListControls) var reviewListControls = true
    @AppStorage(UserDefaults.Key.newReviewsHighlighted) var newReviewsHighlighted = true
}
