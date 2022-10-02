struct Feed: Decodable, Hashable {
    private enum CodingKeys: String, CodingKey {
        case reviews = "entry"
    }

    let reviews: [Review]
}
