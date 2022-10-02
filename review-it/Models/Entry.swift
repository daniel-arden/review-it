struct Entry: Decodable, Hashable, Identifiable {
    private enum CodingKeys: String, CodingKey {
        case author, updated, id, title, content
        case rating = "im:rating"
    }
    let author: Author
    let updated: NestedLabelString
    let rating: NestedLabelString
    let id: NestedLabelString
    let title: NestedLabelString
    let content: NestedLabelString
}
