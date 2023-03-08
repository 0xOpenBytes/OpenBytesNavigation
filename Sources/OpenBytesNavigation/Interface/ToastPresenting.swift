import SwiftUI

/// A protocol for objects that can present a toast.
public protocol ToastPreseting {
    /// Presents a toast with the specified title, message, style and duration.
    ///
    /// - Parameters:
    ///   - title: The title to display in the toast.
    ///   - message: The message to display in the toast.
    ///   - style: The style to use for the toast.
    ///   - duration: The duration to display the toast for. If `nil`, the default duration of 3 seconds is used.
    func toast(
        title: String,
        message: String,
        style: ToastStyle,
        duration: Double?
    )
}
