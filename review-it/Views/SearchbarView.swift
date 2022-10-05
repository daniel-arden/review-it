#if os(macOS)
import AppKit
import SwiftUI

struct SearchbarView: NSViewRepresentable {
    final class Coordinator: NSObject, NSSearchFieldDelegate {
        private var searchbarView: SearchbarView

        init(_ searchbarView: SearchbarView) {
            self.searchbarView = searchbarView
        }

        func controlTextDidChange(_ notification: Notification) {
            guard let searchField = notification.object as? NSSearchField else { return }
            searchbarView.text = searchField.stringValue
        }
    }

    @Binding var text: String

    func makeNSView(context: Context) -> NSSearchField {
        let searchField = NSSearchField(frame: .zero)
        searchField.controlSize = .large
        searchField.placeholderString = "Search for apps on the AppStore"
        return searchField
    }

    func updateNSView(_ searchField: NSSearchField, context: Context) {
        searchField.stringValue = text
        searchField.delegate = context.coordinator
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
#endif
