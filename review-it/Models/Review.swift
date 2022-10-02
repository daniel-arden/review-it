import Foundation

struct Review: Decodable, Hashable, Identifiable {
    private enum CodingKeys: String, CodingKey {
        case _author = "author"
        case _updated = "updated"
        case _title = "title"
        case _id = "id"
        case _content = "content"
        case _rating = "im:rating"
    }

    private let _author: Author
    private let _updated: NestedLabelType<String>
    private let _rating: NestedLabelType<String>
    private let _title: NestedLabelType<String>
    private let _id: NestedLabelType<String>
    private let _content: NestedLabelType<String>

    var id: String { _id.label }
    var authorName: String { _author.name.label }
    var dateUpdated: Date? {
        FormattingService.dateFormatter.date(from: _updated.label)
    }
    var rating: Rating? {
        guard let ratingNumber = Int(_rating.label) else {
            return nil
        }

        return Rating(rawValue: ratingNumber)
    }
    var title: String { _title.label }
    var caption: String { _content.label }
}
