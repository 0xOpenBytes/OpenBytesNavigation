import SwiftUI

extension OpenBytesNavigationPath {
    public struct Toast: Identifiable, Equatable {
        public let id: UUID = UUID()

        public let title: String
        public let message: String
        public let style: ToastStyle
        public let duration: Double?
    }
}
