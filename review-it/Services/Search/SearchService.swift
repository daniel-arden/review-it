import Foundation

final class SearchService {
    private let apiService = APIService.shared
    static let shared = SearchService()

    func searchApp(_ searchText: String, countryCode: String) async throws -> AppSearchResultFeed {
        guard let encodedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            throw SearchError.failedToPercentEncodeSearchText
        }

        let urlString = "https://itunes.apple.com/search?term=\(encodedSearchText)&country=\(countryCode)&media=software"

        return try await apiService.getRequest(urlString: urlString)
    }
}
