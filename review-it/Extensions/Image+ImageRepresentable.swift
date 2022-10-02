import SwiftUI

extension Image {
    init(image: ImageRepresentable) {
        #if os(iOS) || os(watchOS) || os(tvOS)
        self.init(uiImage: image)
        #elseif os(macOS)
        self.init(nsImage: image)
        #endif
    }
}
