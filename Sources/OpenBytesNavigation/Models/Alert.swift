import SwiftUI

extension OpenBytesNavigationPath {
    public struct Alert: Identifiable {
        public let id: UUID = UUID()

        public let title: Text
        public let message: Text?
        public let primaryButton: SwiftUI.Alert.Button
        public let secondaryButton: SwiftUI.Alert.Button
    }
}
