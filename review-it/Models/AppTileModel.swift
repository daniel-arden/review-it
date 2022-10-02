enum AppTileModel: Hashable, Identifiable {
    case addNew
    case app(AppModel)

    var id: Int { hashValue }
}
