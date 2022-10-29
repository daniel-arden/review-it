import Foundation

enum CountryFilter: Identifiable, RawRepresentable, Codable, Hashable, CaseIterable {
    case all
    case country(CountryModel)

    init?(rawValue: String) {
        switch rawValue {
        case "all":
            self = .all
        default:
            guard
                Locale.countryCodes.contains(rawValue),
                let countryModel = CountryModel(countryCode: rawValue)
            else {
                return nil
            }

            self = .country(countryModel)
        }
    }

    var rawValue: String {
        switch self {
        case .all:
            return "all"
        case let .country(countryModel):
            return countryModel.countryCode
        }
    }

    var id: String {
        rawValue
    }

    static var allCases: [CountryFilter] {
        [CountryFilter.all] + Locale.countryCodes.compactMap { CountryFilter(rawValue: $0) }
    }
}
