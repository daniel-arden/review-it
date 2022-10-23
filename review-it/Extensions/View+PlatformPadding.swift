import SwiftUI

private struct PlatformPadding: ViewModifier {
    let platform: Platform
    let edges: Edge.Set
    let length: CGFloat?

    func body(content: Content) -> some View {
        if Platform.current == platform {
            content.padding(edges, length)
        } else {
            content
        }
    }
}

extension View {
    func padding(
        _ platform: Platform = .all,
        _ edges: Edge.Set = .all,
        _ length: CGFloat? = nil
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
