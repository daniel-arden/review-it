import Combine
import SwiftUI

final class AddAppScreenVM: ObservableObject {
    // MARK: Private Properties
    private let moc = PersistenceController.shared.moc
    private let searchService = SearchService.shared
    private let userSettingsService = UserSettingsService.shared
    private var searchCancellable: AnyCancellable?

    // MARK: Public Properties
    @Published var searchText = ""
    @Published var searchState: SearchState = .initial

    init() {
        bind()
    }

    func addApp(_ appSearchResult: AppSearchResult) throws {
        let appModel = AppModel(context: moc)
        appModel.appIconUrl = appSearchResult.appIconUrl
        appModel.appName = appSearchResult.appName
        appModel.developerName = appSearchResult.developerName
        appModel.developerUrl = appSearchResult.developerUrl
        appModel.rating = appSearchResult.ratingRounded
        appModel.id = appSearchResult.id
        appModel.saveDate = .now
        try moc.save()
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
