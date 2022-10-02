struct AppModel: Hashable, Identifiable {
    var id: Int { hashValue }
    let name: String
    let developerName: String
    let icon: ImageRepresentable
}
