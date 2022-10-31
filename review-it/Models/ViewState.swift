enum ViewState<Result: Equatable>: Equatable {
    case error(Error)
    case initial
    case loading
    case results(Result)

    static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.error, .error): return true
        case (.initial, .initial): return true
        case (.results(let lhsModels), .results(let rhsModels)): return lhsModels == rhsModels
        default: return false
        }
    }
}
