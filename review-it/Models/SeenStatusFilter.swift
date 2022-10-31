enum SeenStatusFilter: String, Identifiable, CaseIterable {
    case all
    case seen
    case unseen

    var id: Int { hashValue }
}
