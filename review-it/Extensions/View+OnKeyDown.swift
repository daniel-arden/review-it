#if os(macOS)
import AppKit
import Carbon.HIToolbox
import SwiftUI

// MARK: - View Extension
extension View {
    func onKeyDown(_ onKeyDown: @escaping (UInt16) -> Void) -> some View {
        modifier(OnKeyDownModifier(onKeyDown: onKeyDown))
    }

    func onKeyDown(_ key: KeyboardKey, action: @escaping () -> Void) -> some View {
        onKeyDown { if $0 == key.keyCode { action() } }
    }
}

// MARK: - Keyboard Key
enum KeyboardKey {
    case escape

    var keyCode: Int {
        switch self {
        case .escape: return kVK_Escape
        }
    }
}

// MARK: - View Modifier
private struct OnKeyDownModifier: ViewModifier {
    let onKeyDown: ((UInt16) -> Void)?

    func body(content: Content) -> some View {
        ZStack {
            KeyDownView(onKeyDown: onKeyDown)
            content
        }
    }
}

// MARK: - Wrapper Views
private final class KeyDownNSView: NSView {
    var onKeyDownEvent: ((UInt16) -> Void)?

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { (aEvent) -> NSEvent? in
            self.keyDown(with: aEvent)
            return aEvent
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func keyDown(with event: NSEvent) {
        onKeyDownEvent?(event.keyCode)
    }
}

private struct KeyDownView: NSViewRepresentable {
    let onKeyDown: ((UInt16) -> Void)?

    func makeNSView(context: Context) -> some NSView {
        let view = KeyDownNSView(frame: .zero)
        view.onKeyDownEvent = onKeyDown
        return view
    }

    func updateNSView(_ nsView: NSViewType, context: Context) {}
}
#endif
