import Foundation

struct CountryModel: Identifiable, Hashable {
    var id: String { countryCode }
    let countryCode: CountryCode
    let countryName: CountryName

    init(countryCode: CountryCode, countryName: CountryName) {
        self.countryCode = countryCode
        self.countryName = countryName
    }

    init?(countryCode: CountryCode) {
        self.countryCode = countryCode
        guard let countryName = countryCode.countryName else {
            return nil
        }
        self.countryName = countryName
    }

    var flag: String {
        let base: UInt32 = 127397
        var result = ""

        for unicodeScalar in countryCode.uppercased().unicodeScalars {
            result.unicodeScalars.append(UnicodeScalar(base + unicodeScalar.value)!)
        }

        return result
    }

    var fullDescription: String {
        "\(flag) \(countryCode) - \(countryName)"
    }
}
