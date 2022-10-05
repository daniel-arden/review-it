import SwiftUI

final class AddAppScreenVM: ObservableObject {
    @Published var searchText = ""
    @Published var searchState: SearchState = .initial
}

extension AddAppScreenVM {
    func search() {
        
    }
}

extension AddAppScreenVM {
    enum SearchState: Equatable {
        case error(Error)
        case initial
        case results([AppModel])

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
