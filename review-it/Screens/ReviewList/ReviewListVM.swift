import SwiftUI

final class ReviewListVM: ObservableObject {
    private let apiService = APIService.shared

    @Published private(set) var reviews: [Entry] = []
}

extension ReviewListVM {
    @MainActor
    func fetchReviews() async throws {
        let reviewFeed: ReviewFeed = try await apiService.getRequest(
            urlString: "https://itunes.apple.com/us/rss/customerreviews/id=389801252/json"
        )
        reviews = reviewFeed.feed.entry
    }
}
