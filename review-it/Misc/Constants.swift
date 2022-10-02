enum Constants {
    static func reviewUrlString(for appId: String) -> String {
        "https://itunes.apple.com/us/rss/customerreviews/id=\(appId)/json"
    }
}
