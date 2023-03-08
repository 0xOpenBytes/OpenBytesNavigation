import SwiftUI

/// A protocol for objects that can pop backwards.
public protocol BackwardNavigatable {
    /// Pops the current view off the navigation stack.
    func pop()
}
