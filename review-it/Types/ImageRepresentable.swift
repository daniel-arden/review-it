#if os(iOS)
import UIKit

typealias ImageRepresentable = UIImage
#elseif os(macOS)
import AppKit

typealias ImageRepresentable = NSImage
#endif
