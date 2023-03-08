import SwiftUI

/// A protocol for objects that can present an action sheet.
public protocol ActionSheetPresenting {
    /// Presents an action sheet with the specified title, actions, and message.
    ///
    /// - Parameters:
    ///   - title: The title of the action sheet.
    ///   - actions: A closure that returns the view of the action sheet's buttons.
    ///   - message: A closure that returns the view of the action sheet's message.
    func actionSheet<ActionContent: View, MessageContent: View>(
        title: String,
        actions: @escaping () -> ActionContent,
        message: @escaping () -> MessageContent
    )
}
