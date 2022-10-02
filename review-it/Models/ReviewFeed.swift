struct ReviewFeed: Decodable, Hashable, Identifiable {
    var id: Int { hashValue }
    let feed: Feed
}
