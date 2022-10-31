import Combine
import CoreData
import SwiftUI

final class ReviewListVM: ObservableObject {
    @ObservedObject private var userSettings = UserSettingsService.shared
    private let apiService = APIService.shared
    private let moc = PersistenceController.shared.moc
    private var countryFilterCancellable: AnyCancellable?

    @AppStorage(UserDefaults.Key.selectedAppId) var selectedAppId: Int? {
        didSet {
            guard selectedAppId != oldValue else { return }
            guard selectedAppId != nil else {
                removeReviews()
                return
            }
            fetchReviews()
        }
    }

    @AppStorage(UserDefaults.Key.recentCountryFilters) var recentCountryFilters: [CountryFilter] = []
    @Published private(set) var reviews: [Review] = []

    init() {
        selectLast()
        fetchReviews()

        countryFilterCancellable = userSettings.countryFilterDidChange
            .sink { [weak self] _ in
                self?.fetchReviews()
            }
    }
}

extension ReviewListVM {
    func fetchReviews() {
        Task {
            guard let selectedAppId = selectedAppId else {
                return
            }

            let reviewFeed: ReviewFeed = try await apiService.getRequest(
                urlString: Constants.reviewUrlString(
                    for: selectedAppId,
                    countryCode: userSettings.selectedCountryFilter.rawValue
                )
            )

            await MainActor.run {
                reviews = reviewFeed.reviews
            }
        }
    }

    func removeReviews() {
        reviews = []
    }

    func selectLast() {
        Task {
            let request = NSFetchRequest<AppModel>(entityName: String(describing: AppModel.self))
            guard let results = try? moc.fetch(request) else { return }

            await MainActor.run {
                // The results come sorted by date, therefore the last added is the one we want to select
                selectedAppId = results.last?.id
            }
        }
    }
}
