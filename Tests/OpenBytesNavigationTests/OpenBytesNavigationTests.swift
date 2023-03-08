import Disk
import SwiftUI
import XCTest
@testable import OpenBytesNavigation

final class OpenBytesNavigationTests: XCTestCase {
    func testOpenBytesNavigationPathPreviewSaveLoad() throws {
        let id = "test"
        let path = OpenBytesNavigationPath(id: id, isPreview: true)

        XCTAssertEqual(path.navigation.count, 0)

        path.push("Value")

        XCTAssertEqual(path.navigation.count, 1)

        path.save()

        let doesFileExist = try Disk.fileExists(
            atPath: "./\(OpenBytesNavigationPath.name(id: id))"
        )

        // When isPreview is true the navigation path will not save
        XCTAssertFalse(doesFileExist)

        let loadedPath = OpenBytesNavigationPath.load(id: id)

        XCTAssertNotEqual(loadedPath.navigation.count, path.navigation.count)
    }

    func testOpenBytesNavigationPathSaveLoad() throws {
        let id = "test"
        let path = OpenBytesNavigationPath(id: id, isPreview: false)

        XCTAssertEqual(path.navigation.count, 0)

        path.push("Value")

        XCTAssertEqual(path.navigation.count, 1)

        path.save()

        let loadedPath = OpenBytesNavigationPath.load(id: id)

        XCTAssertEqual(loadedPath.navigation.count, path.navigation.count)

        let doesFileExist = try Disk.fileExists(
            atPath: "./\(OpenBytesNavigationPath.name(id: id))"
        )

        // File should be deleted on load(id:)
        XCTAssertFalse(doesFileExist)
    }

    func testOpenBytesNavigationPathActionSheet() throws {
        let path = OpenBytesNavigationPath(id: "test", isPreview: true)

        XCTAssertNil(path.actionSheet)

        path.actionSheet(
            title: "Test",
            actions: EmptyView.init,
            message: EmptyView.init
        )

        XCTAssertNotNil(path.actionSheet)
    }

    func testOpenBytesNavigationPathAlert() throws {
        let path = OpenBytesNavigationPath(id: "test", isPreview: true)

        XCTAssertNil(path.alert)

        path.alert(
            title: Text("Test"),
            primaryButton: .default(Text("Done")),
            secondaryButton: .cancel()
        )

        XCTAssertNotNil(path.alert)
    }

    func testOpenBytesNavigationPathModal() throws {
        let path = OpenBytesNavigationPath(id: "test", isPreview: true)

        XCTAssertNil(path.modal)

        path.modal(body: EmptyView.init)

        XCTAssertNotNil(path.modal)
    }

    func testOpenBytesNavigationPathToast() throws {
        let path = OpenBytesNavigationPath(id: "test", isPreview: true)

        XCTAssertNil(path.toast)

        path.toast(title: "Test", message: "Toast", style: .success)

        XCTAssertNotNil(path.toast)
    }

    func testOpenBytesNavigationPushPop() throws {
        let path = OpenBytesNavigationPath(id: "test", isPreview: true)

        XCTAssertEqual(path.navigation.count, 0)

        path.push("Value")

        XCTAssertEqual(path.navigation.count, 1)

        path.pop()

        XCTAssertEqual(path.navigation.count, 0)
    }
}
