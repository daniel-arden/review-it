import CoreData
import SwiftUI

final class ReviewListVM: ObservableObject {
    private let apiService = APIService.shared
    private let moc = PersistenceController.shared.container.viewContext

    @AppStorage(UserDefaults.Key.selectedAppId) var selectedAppId: Int? {
        didSet {
            guard selectedAppId != oldValue else { return }
            fetchReviews()
        }
    }
    @Published private(set) var reviews: [Review] = []

    init() {
        selectLast()
        fetchReviews()
    }
}

extension ReviewListVM {
    func fetchReviews() {
        Task {
            guard let selectedAppId = selectedAppId else {
                return
            }

            let reviewFeed: ReviewFeed = try await apiService.getRequest(
                urlString: Constants.reviewUrlString(for: selectedAppId)
            )

            await MainActor.run {
                reviews = reviewFeed.reviews
            }
        }
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
