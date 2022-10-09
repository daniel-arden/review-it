import Foundation

struct AppModel: Identifiable, Hashable {
    let appIconUrl: URL
    let appName: String
    let developerName: String
    let developerUrl: URL
    let rating: Float
    let id: Int
}
