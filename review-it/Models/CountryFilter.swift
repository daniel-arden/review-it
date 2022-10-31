import Foundation

enum CountryFilter: Identifiable, RawRepresentable, Codable, Hashable, CaseIterable, Equatable {
    case country(CountryModel)

    init?(rawValue: String) {
        switch rawValue {
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
        case let .country(countryModel):
            return countryModel.countryCode
        }
    }

    var id: String {
        rawValue
    }

    static var allCases: [CountryFilter] {
        Locale.countryCodes.compactMap { CountryFilter(rawValue: $0) }
    }
}

extension CountryFilter {
    static var `default`: CountryFilter {
        CountryFilter(rawValue: "US")!
    }
}
