import SwiftUI

private struct PlatformPadding: ViewModifier {
    let platform: Platform
    let edges: Edge.Set
    let length: CGFloat?

    func body(content: Content) -> some View {
        if platform == .iOS {
            #if os(iOS)
            content.padding(edges, length)
            #endif
            content
        }

        if platform == .macOS {
            #if os(macOS)
            content.padding(edges, length)
            #endif
            content
        }

        if platform == .tvOS {
            #if os(tvOS)
            content.padding(edges, length)
            #endif
            content
        }

        if platform == .watchOS {
            #if os(macOS)
            content.padding(edges, length)
            #endif
            content
        }
    }
}

extension View {
    func padding(
        platform: Platform = .all,
        edges: Edge.Set = .all,
        length: CGFloat? = nil
    ) -> some View {
        modifier(
            PlatformPadding(
                platform: platform,
                edges: edges,
                length: length
            )
        )
    }
}
