import Foundation

struct AppSearchResultFeed: Decodable, Hashable {
    let results: [AppSearchResult]
}

struct AppSearchResult: Identifiable, Decodable, Hashable {
    var id: Int { hashValue }
    let trackName: String
    let screenshotUrls: [String]
    let artworkUrl100: String
    let artistViewUrl: String
    let sellerName: String
    let userRatingCount: Int
}
