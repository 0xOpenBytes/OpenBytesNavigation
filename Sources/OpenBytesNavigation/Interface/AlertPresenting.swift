import SwiftUI

/// A protocol for objects that can present an alert.
public protocol AlertPresenting {
    /// Presents an alert with the specified title, message, and buttons.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message of the alert, or `nil` if there is no message.
    ///   - primaryButton: The primary button of the alert.
    ///   - secondaryButton: The secondary button of the alert.
    func alert(
        title: Text,
        message: Text?,
        primaryButton: Alert.Button,
        secondaryButton: Alert.Button
    )
}
