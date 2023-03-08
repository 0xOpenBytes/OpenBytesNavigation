import SwiftUI

/// A protocol for objects that can present a modal view.
public protocol ModalPresenting {
    /// Presents a modal view with the specified content.
    ///
    /// - Parameter body: A closure that returns the content view of the modal.
    func modal<Content: View>(
        body: @escaping () -> Content
    )
}
