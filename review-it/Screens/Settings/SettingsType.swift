import SwiftUI

enum SettingsType: String, CaseIterable, Identifiable {
    var id: String { rawValue }

    case general
    case alerts
    case account
}

extension SettingsType {
    @ViewBuilder
    var view: some View {
        switch self {
        case .general:
            SettingsGeneralView()
        case .alerts:
            SettingsAlertsView()
        case .account:
            SettingsAccountView()
        }
    }
}

#if os(macOS)
extension SettingsType {
    var iconSystemName: String {
        switch self {
        case .general:
            return "gear"
        case .alerts:
            return "bell"
        case .account:
            return "person"
        }
    }
}
#endif
