import SwiftUI

extension OpenBytesNavigationPath {
    public struct Modal: Identifiable {
        public let id: UUID = UUID()

        public var body: () -> AnyView
    }
}
