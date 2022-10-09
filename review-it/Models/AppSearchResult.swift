import Foundation

struct AppSearchResultFeed: Decodable, Hashable {
    let results: [AppSearchResult]
}

struct AppSearchResult: Identifiable, Decodable, Hashable {
    private let artistViewUrl: URL
    private let artworkUrl100: URL
    private let sellerName: String
    private let trackId: Int
    private let trackName: String

    var appIconUrl: URL { artworkUrl100 }
    var appName: String { trackName }
    var developerName: String { sellerName }
    var developerUrl: URL { artistViewUrl }
    var id: Int { trackId }
}
