struct NestedLabelType<T: Decodable & Hashable>: Decodable, Hashable {
    let label: T
}
