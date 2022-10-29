import Foundation

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard
            let data = rawValue.data(using: .utf8),
            let result = try? FormattersCoders.jsonDecoder.decode([Element].self, from: data)
        else {
            return nil
        }

        self = result
    }

    public var rawValue: String {
        guard
            let data = try? FormattersCoders.jsonEncoder.encode(self),
            let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }

        return result
    }
}
