# OpenBytesNavigation

OpenBytesNavigation is a SwiftUI library that provides a flexible and easy-to-use navigation system for your SwiftUI apps. It allows you to navigate between views, show modal views, display alerts and action sheets, and show toast notifications.

## Usage

To use OpenBytesNavigation, you need to create an instance of `OpenBytesNavigationPath`, which keeps track of the navigation state. You can then use the `OpenBytesNavigationView` view to display your content and provide navigation functionality.

```swift
import OpenBytesNavigation
import SwiftUI

struct ContentView: View {
    @ObservedObject private var path = OpenBytesNavigationPath(id: "path_id")

    var body: some View {
        OpenBytesNavigationView(path: path) {
            // your content here
        }
    }
}
```

## Navigation Examples

### SwiftUI Previews

Call the `preview` function on `OpenBytesNavigationView` to create a preview of your navigation stack. This is useful for SwiftUI previews as the path won't be able to save.

```swift
struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        OpenBytesNavigationView.preview {
            // your content here
        }
    }
}
```

### Action Sheet

```swift
path.actionSheet(
    title: "Delete Item?",
    actions: {
        Button("Delete", role: .destructive) {
            // Delete item
        }
    },
    message: {
        Text("Are you sure you want to delete this item?")
    }
)
```

### Alert

```swift
path.alert(
    title: Text("Error"),
    message: Text("An error occurred. Please try again."),
    primaryButton: .default(Text("OK")),
    secondaryButton: .cancel()
)
```

### Modal

```swift
path.modal(
    body: {
        Text("Modal body")
    }
)
```

### Toast

```swift
path.toast(
    title: "Success",
    message: "Item saved successfully",
    style: .success
)
```

### Push

```swift
.navigationDestination(for: Date.self, destination: { ClockView(date: $0) })
...
path.push(Date())
```

### Pop

```swift
path.pop()
```

### Save and Load

```swift
let id = "test"
let path = OpenBytesNavigationPath(id: id, isPreview: false)

XCTAssertEqual(path.navigation.count, 0)

path.push("Value")

XCTAssertEqual(path.navigation.count, 1)

path.save()

let loadedPath = OpenBytesNavigationPath.load(id: id)

XCTAssertEqual(loadedPath.navigation.count, path.navigation.count)
```
