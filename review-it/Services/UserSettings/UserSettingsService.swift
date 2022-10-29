import SwiftUI

final class UserSettingsService: ObservableObject {
    static let shared = UserSettingsService()

    @AppStorage(UserDefaults.Key.selectedAppId) var selectedAppId: Int?
    @AppStorage(UserDefaults.Key.reviewListControls) var reviewListControls = true
    @AppStorage(UserDefaults.Key.newReviewsHighlighted) var newReviewsHighlighted = true
    @AppStorage(UserDefaults.Key.recentCountryFilters) private(set) var recentCountryFilters: [CountryFilter] = []
    @AppStorage(UserDefaults.Key.selectedCountryFilter) var selectedCountryFilter: CountryFilter = .all {
        didSet {
            addRecentCountryFilter(selectedCountryFilter)
        }
    }
}

extension UserSettingsService {
    @MainActor
    func reset() throws {
        reviewListControls = true
        newReviewsHighlighted = true
        selectedAppId = nil
        try PersistenceController.shared.reset()
    }

    func addRecentCountryFilter(_ countryFilter: CountryFilter) {
        guard recentCountryFilters.count <= 5 else {
            assertionFailure("Country filter count should never exceed 5")
            return
        }

        guard countryFilter != .all else { return }

        if recentCountryFilters.count == 5 {
            var result = recentCountryFilters.dropLast()
            result.insert(countryFilter, at: 0)
            recentCountryFilters = Array(result)
            return
        }

        recentCountryFilters.insert(countryFilter, at: 0)
    }
}
