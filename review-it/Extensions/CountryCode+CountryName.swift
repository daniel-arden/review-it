import Foundation

extension CountryCode {
    var countryName: CountryName? {
        (NSLocale.system as NSLocale).displayName(
            forKey: .countryCode,
            value: self
        )
    }
}
