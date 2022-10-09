import Combine
import SwiftUI

final class AddAppScreenVM: ObservableObject {
    // MARK: Private Properties
    private let searchService = SearchService.shared
    private var searchCancellable: AnyCancellable?

    // MARK: Public Properties
    @Published var searchText = ""
    @Published var searchState: SearchState = .initial

    init() {
        bind()
    }
}

// MARK: - Private API
private extension AddAppScreenVM {
    func bind() {
        searchCancellable = $searchText
            .filter { !$0.isEmpty }
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines)}
            .removeDuplicates()
            .sink { [weak self] searchText in
                self?.performSearch(of: searchText)
            }
    }

    func performSearch(of searchText: String) {
        Task { @MainActor in
            do {
                searchState = .searching
                let resultFeed = try await searchService.searchApp(searchText, countryCode: "us")
                searchState = .results(resultFeed.results)
            } catch {
                searchState = .error(error)
            }
        }
    }
}

// MARK: - SearchState
extension AddAppScreenVM {
    enum SearchState: Equatable {
        case error(Error)
        case initial
        case searching
        case results([AppSearchResult])

        static func == (lhs: AddAppScreenVM.SearchState, rhs: AddAppScreenVM.SearchState) -> Bool {
            switch (lhs, rhs) {
            case (.error, .error): return true
            case (.initial, .initial): return true
            case (.results(let lhsModels), .results(let rhsModels)): return lhsModels == rhsModels
            default: return false
            }
        }
    }
}
