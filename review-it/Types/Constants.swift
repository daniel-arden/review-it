enum Constants {
    static func reviewUrlString(for appId: Int) -> String {
        "https://itunes.apple.com/us/rss/customerreviews/id=\(appId)/json"
    }

    static let persistentContainerName = "review-it"
    static let persistentContainerPath = "/dev/null"
}
