import Foundation

extension UserDefaults {
    /**
     UserDefaults Keys are Strings stored as static constants inside the `Key` namespace so
     that we don't have to access them as `.rawValue`, which is too verbose.
     */
    enum Key {
        static let selectedAppId = "selectedAppId"

        // MARK: - User Settings
        /// ReviewListScreen controls' visibility
        static let reviewListControls = "reviewListControls"

        /// ReviewListScreen's highlighted appearance for new reviews
        static let newReviewsHighlighted = "newReviewsHighlighted"

        /// Country codes that were recently selected as filters
        static let recentCountryFilters = "recentCountryFilters"

        /// Currently Selected country filter
        static let selectedCountryFilter = "selectedCountryFilter"

        /// Currently Selected Seen Status filter
        static let seenStatusFilter = "seenStatusFilter"
    }
}
