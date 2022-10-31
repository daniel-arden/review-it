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

    @Published private(set) var viewState: ViewState<[Review]> = .initial

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
        Task { @MainActor in
            do {
                guard let selectedAppId = selectedAppId else {
                    return
                }

                viewState = .loading

                let reviewFeed: ReviewFeed = try await apiService.getRequest(
                    urlString: Constants.reviewUrlString(
                        for: selectedAppId,
                        countryCode: userSettings.selectedCountryFilter.rawValue
                    )
                )

                viewState = .results(reviewFeed.reviews)
            } catch {
                viewState = .error(error)
            }
        }
    }

    func removeReviews() {
        viewState = .initial
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

    func removeApp(_ appModel: AppModel) {
        withAnimation {
            moc.delete(appModel)
            try? moc.save()
            selectLast()
        }
    }
}
