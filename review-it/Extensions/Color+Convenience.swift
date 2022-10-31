import SwiftUI

extension Color {
    static let backgroundPrimary = Color("Background Primary")
    #if os(macOS)
    static let backgroundSecondary = Color("Background Secondary macOS")
    #else
    static let backgroundSecondary = Color("Background Secondary")
    #endif
    static let backgroundTertiary = Color("Background Tertiary")
}
