import Foundation

struct AppSearchResultFeed: Decodable, Hashable {
    let results: [AppSearchResult]
}

struct AppSearchResult: Identifiable, Decodable, Hashable {
    var id: Int { hashValue }
    let trackName: String
    let artworkUrl100: URL
    let artistViewUrl: URL
    let sellerName: String
    let userRatingCount: Int
}
