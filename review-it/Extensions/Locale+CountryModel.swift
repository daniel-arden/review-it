import Foundation

extension Locale {
    static let countryCodes = NSLocale.isoCountryCodes

    static let countryModels: [CountryModel] = {
        countryCodes.compactMap { countryCode in
            let countryCode = countryCode as CountryCode

            if let countryName = countryCode.countryName {
                return CountryModel(countryCode: countryCode, countryName: countryName)
            } else {
                return nil
            }
        }
    }()

}
