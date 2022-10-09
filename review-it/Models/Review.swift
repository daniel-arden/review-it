import Foundation

struct Review: Decodable, Hashable, Identifiable {
    private enum CodingKeys: String, CodingKey {
        case _author = "author"
        case _content = "content"
        case _id = "id"
        case _rating = "im:rating"
        case _title = "title"
        case _updated = "updated"
    }

    private let _author: Author
    private let _content: NestedLabelType<String>
    private let _id: NestedLabelType<String>
    private let _rating: NestedLabelType<String>
    private let _title: NestedLabelType<String>
    private let _updated: NestedLabelType<String>

    var authorName: String { _author.name.label }
    var caption: String { _content.label }
    var dateUpdated: Date? {
        FormattingService.dateFormatter.date(from: _updated.label)
    }
    var id: String { _id.label }
    var rating: Float? {
        guard let ratingNumber = Float(_rating.label) else {
            return nil
        }

        return ratingNumber
    }
    var title: String { _title.label }
}
