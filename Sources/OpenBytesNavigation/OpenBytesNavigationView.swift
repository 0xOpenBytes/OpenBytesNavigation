import SwiftUI

/// A SwiftUI view that uses `OpenBytesNavigationPath` and NavigationStack
public struct OpenBytesNavigationView<RootView: View>: View {
    @ObservedObject private var path: OpenBytesNavigationPath
    private let rootView: () -> RootView

    /// Initializes a new instance of `OpenBytesNavigationView`.
    ///
    ///   - Parameters:
    ///     - path: The `OpenBytesNavigationPath` for the navigation view.
    ///     - rootView: A closure that returns a `RootView`.
    ///
    public init(
        path: OpenBytesNavigationPath,
        rootView: @escaping () -> RootView
    ) {
        self.path = path
        self.rootView = rootView
    }

    public var body: some View {
        NavigationStack(path: $path.navigation) {
            rootView()
                .sheet(
                    item: $path.modal,
                    content: { modal in
                        modal.body()
                    }
                )
                .alert(
                    item: $path.alert,
                    content: { alert in
                        SwiftUI.Alert(
                            title: alert.title,
                            message: alert.message,
                            primaryButton: alert.primaryButton,
                            secondaryButton: alert.secondaryButton
                        )
                    }
                )
                .confirmationDialog(
                    path.actionSheet?.title ?? "",
                    isPresented: Binding(
                        get: { path.actionSheet != nil },
                        set: { newValue  in
                            if newValue == false {
                                path.actionSheet = nil
                            }
                        }
                    ),
                    presenting: path.actionSheet,
                    actions: { actionSheet in
                        actionSheet.actions()
                    },
                    message: { actionSheet in
                        actionSheet.message()
                    }
                )
                .modifier(ToastModifer(toast: $path.toast))
        }
    }
}

extension OpenBytesNavigationView {
    /// Returns a preview instance of `OpenBytesNavigationView`.
    ///
    /// This function can be used to generate a preview instance of `OpenBytesNavigationView`
    /// for use in Xcode's SwiftUI preview canvas.
    ///
    /// - Parameter content: A closure that returns a `RootView`.
    /// - Returns: A preview instance of `OpenBytesNavigationView`.
    public static func preview(_ content: @escaping () -> RootView) -> OpenBytesNavigationView {
        OpenBytesNavigationView(
            path: OpenBytesNavigationPath(
                id: UUID().uuidString,
                isPreview: true
            ),
            rootView: content
        )
    }
}
