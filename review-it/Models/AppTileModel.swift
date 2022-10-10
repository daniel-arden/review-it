enum AppTileModel: Hashable, Identifiable {
    case addNew
    case app(AppModel)

    var id: Int {
        switch self {
        case .addNew:
            return hashValue
        case .app(let appModel):
            return appModel.id
        }
    }
}
