struct ReviewFeed: Decodable, Hashable, Identifiable {
    var id: Int { hashValue }
    var reviews: [Review] { feed.reviews }

    private let feed: Feed
}
