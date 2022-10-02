import SwiftUI

final class ReviewListVM: ObservableObject {
    private let apiService = APIService.shared

    @Published private(set) var tileModels: [AppTileModel] = [.addNew]
    @Published var selectedAppModel: AppModel?
    @Published private(set) var reviews: [Review] = []
}

extension ReviewListVM {
    @MainActor
    func fetchReviews() async throws {
        let reviewFeed: ReviewFeed = try await apiService.getRequest(
            urlString: Constants.reviewUrlString(for: "389801252")
        )
        reviews = reviewFeed.reviews
    }
}
