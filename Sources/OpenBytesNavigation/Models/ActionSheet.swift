import SwiftUI

extension OpenBytesNavigationPath {
    public struct ActionSheet: Identifiable {
        public let id: UUID = UUID()
        public let title: String
        public let actions: () -> AnyView
        public let message: () -> AnyView
    }
}

