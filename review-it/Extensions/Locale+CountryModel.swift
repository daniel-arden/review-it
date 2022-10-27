import Foundation

extension Locale {
    static let countryModels: [CountryModel] = {
        NSLocale.isoCountryCodes.compactMap { countryCode in
            let countryCode = countryCode as CountryCode

            if let countryName = countryCode.countryName {
                return CountryModel(countryCode: countryCode, countryName: countryName)
            } else {
                return nil
            }
        }
    }()

}
