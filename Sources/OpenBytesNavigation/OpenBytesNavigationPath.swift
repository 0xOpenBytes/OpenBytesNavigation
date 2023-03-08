import Disk
import SwiftUI

/// A class that manages the navigation, presentation of modals, alerts, action sheets, and toasts in a SwiftUI app.
open class OpenBytesNavigationPath: ObservableObject {
    /// A prefix used for the filenames of the saved navigation paths.
    private static let filePrefix = "OpenBytesNavigationPath"

    /// The ID of the navigation path.
    public let id: String

    /// The navigation path object that keeps track of the navigation stack.
    @Published open var navigation: NavigationPath

    /// The modal object that holds the current modal view to be presented.
    @Published open var modal: Modal?

    /// The alert object that holds the current alert to be presented.
    @Published open var alert: Alert?

    /// The action sheet object that holds the current action sheet to be presented.
    @Published open var actionSheet: ActionSheet?

    /// The toast object that holds the current toast to be presented.
    @Published open var toast: Toast?

    /// A flag that indicates if the navigation path is in preview mode.
    open var isPreview: Bool

    /// Initializes a new instance of `OpenBytesNavigationPath`.
    ///
    /// - Parameters:
    ///   - id: The ID of the navigation path.
    ///   - isPreview: A flag that indicates if the navigation path is in preview mode.
    ///   - codable: A representation of the navigation path in its codable form.
    public init(
        id: String,
        isPreview: Bool = false,
        _ codable: NavigationPath.CodableRepresentation? = nil
    ) {
        self.id = id
        self.isPreview = isPreview

        if let codable {
            navigation = NavigationPath(codable)
        } else {
            navigation = NavigationPath()
        }

        modal = nil
        alert = nil
        actionSheet = nil
        toast = nil
    }

    /// Saves the current navigation path to disk.
    open func save() {
        guard
            isPreview == false,
            let representation = navigation.codable
        else { return }

        do {
            try Disk.out(representation, filename: Self.name(id: id))
        } catch {
            print(error.localizedDescription)
        }
    }

    /// Loads the navigation path from disk.
    ///
    /// - Parameter id: The ID of the navigation path.
    /// - Returns: An instance of `OpenBytesNavigationPath`.
    public static func load(id: String) -> OpenBytesNavigationPath {
        defer {
            try? Disk.delete(filename: name(id: id))
        }

        return OpenBytesNavigationPath(id: id, try? Disk.in(filename: name(id: id)))
    }

    /// Generates a filename for the given navigation path ID.
    ///
    /// - Parameter id: The ID of the navigation path.
    /// - Returns: A string representing the filename of the navigation path.
    public static func name(id: String) -> String {
        "\(filePrefix).\(id)"
    }
}


extension OpenBytesNavigationPath: ActionSheetPresenting, AlertPresenting, ModalPresenting,
                           ForwardNavigatable, BackwardNavigatable, ToastPreseting {

    public func actionSheet<ActionContent: View, MessageContent: View>(
        title: String,
        actions: @escaping () -> ActionContent,
        message: @escaping () -> MessageContent
    ) {
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.actionSheet(title: title, actions: actions, message: message)
            }
            return
        }

        actionSheet = ActionSheet(
            title: title,
            actions: { AnyView(actions()) },
            message: { AnyView(message()) }
        )
    }

    public func alert(
        title: Text,
        message: Text? = nil,
        primaryButton: SwiftUI.Alert.Button,
        secondaryButton: SwiftUI.Alert.Button
    ) {
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.alert(
                    title: title,
                    message: message,
                    primaryButton: primaryButton,
                    secondaryButton: secondaryButton
                )
            }
            return
        }

        alert = Alert(
            title: title,
            message: message,
            primaryButton: primaryButton,
            secondaryButton: secondaryButton
        )
    }

    public func modal<Content: View>(
        body: @escaping () -> Content
    ) {
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.modal(body: body)
            }
            return
        }

        modal = Modal(
            body: { AnyView(body()) }
        )
    }

    public func toast(
        title: String,
        message: String,
        style: ToastStyle,
        duration: Double? = 3
    ) {
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.toast(
                    title: title,
                    message: message,
                    style: style,
                    duration: duration
                )
            }
            return
        }

        toast = Toast(
            title: title,
            message: message,
            style: style,
            duration: duration
        )
    }

    public func push<V>(_ value: V) where V: Hashable {
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.push(value)
            }
            return
        }

        navigation.append(value)
    }

    public func push<V>(_ value: V) where V: Codable, V: Hashable {
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.push(value)
            }
            return
        }

        navigation.append(value)
    }

    public func pop() {
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.pop()
            }
            return
        }

        guard navigation.isEmpty == false else {
            return
        }

        navigation.removeLast()
    }
}
