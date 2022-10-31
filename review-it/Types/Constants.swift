enum Constants {
    static func reviewUrlString(for appId: Int, countryCode: CountryCode) -> String {
        "https://itunes.apple.com/\(countryCode)/rss/customerreviews/id=\(appId)/json"
    }

    static let persistentContainerName = "review-it"
    static let persistentContainerPath = "/dev/null"
}
