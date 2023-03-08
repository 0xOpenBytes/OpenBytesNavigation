import SwiftUI

/// A protocol for objects that can push a view.
public protocol ForwardNavigatable {
    /// Pushes a new view onto the navigation stack.
    ///
    /// - Parameter value: The value to use to create the new view.
    func push<V>(_ value: V) where V: Hashable

    /// Pushes a new view onto the navigation stack.
    ///
    /// - Parameter value: The value to use to create the new view.
    func push<V>(_ value: V) where V: Codable, V: Hashable
}
