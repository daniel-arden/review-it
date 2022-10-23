struct Platform: OptionSet {
    // TODO: Cheeck if this is a proper way to initialize an OptionSet

    init() {
        rawValue = ""
    }

    init(rawValue: String) { self.rawValue = rawValue }

    let rawValue: String

    static let iOS = Platform(rawValue: "iOS")
    static let macOS = Platform(rawValue: "macOS")
    static let tvOS = Platform(rawValue: "tvOS")
    static let watchOS = Platform(rawValue: "watchOS")

    static let all: Platform = [.iOS, .macOS, .tvOS, .watchOS]

    mutating func formUnion(_ other: __owned Platform) {
        self = self.union(other)
    }

    mutating func formIntersection(_ other: Platform) {
        self = self.intersection(other)
    }

    mutating func formSymmetricDifference(_ other: __owned Platform) {
        self = self.symmetricDifference(other)
    }

    static var current: Platform {
        #if os(iOS)
        return .iOS
        #elseif os(macOS)
        return .macOS
        #elseif os(tvOS)
        return .tvOS
        #elseif os(watchOS)
        return .watchOS
        #else
        fatalError("Unknown platform. Make sure you are running the code on iOS, macOS, tvOS or watchOS")
        #endif
    }
}
