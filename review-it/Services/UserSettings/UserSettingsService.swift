import Combine
import SwiftUI

final class UserSettingsService: ObservableObject {
    static let shared = UserSettingsService()

    @AppStorage(UserDefaults.Key.selectedAppId) var selectedAppId: Int?
    @AppStorage(UserDefaults.Key.reviewListControls) var reviewListControls = true
    @AppStorage(UserDefaults.Key.newReviewsHighlighted) var newReviewsHighlighted = true
    @AppStorage(UserDefaults.Key.recentCountryFilters) private(set) var recentCountryFilters: [CountryFilter] = []
    @AppStorage(UserDefaults.Key.selectedCountryFilter) var selectedCountryFilter: CountryFilter = .default {
        didSet {
            countryFilterDidChange.send(selectedCountryFilter)
            addRecentCountryFilter(selectedCountryFilter)
        }
    }
    @AppStorage(UserDefaults.Key.seenStatusFilter) var seenStatusFilter: SeenStatusFilter = .all

    let countryFilterDidChange = PassthroughSubject<CountryFilter, Never>()
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

        if recentCountryFilters.contains(countryFilter) {
            recentCountryFilters.removeAll { $0 == countryFilter }
        }

        if recentCountryFilters.count == 5 {
            var result = recentCountryFilters.dropLast()
            result.insert(countryFilter, at: 0)
            recentCountryFilters = Array(result)
            return
        }

        recentCountryFilters.insert(countryFilter, at: 0)
    }
}
