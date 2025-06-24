
# 📐 Orientations

✅ **A Flutter plugin to fully control iOS device orientations at runtime — the right way.**

---

⚠️ **Heads up**

This plugin is created with **Swift Package Manager (SPM) ON**.  
We have **not tested it extensively on older Flutter projects that do not have SPM enabled**.

If you encounter any issues, please feel free to **open an issue or submit a pull request** — contributions are very welcome! 🚀


## ✨ Why use this?

- Flutter’s `SystemChrome.setPreferredOrientations` **does not work properly on iOS** for forcing orientation during runtime.
- This plugin fixes that by bridging to native Swift and overriding iOS’s system behavior properly.
- Works on both iOS and other platforms (it will fallback to `SystemChrome`).

---

## 📦 Install

In your `pubspec.yaml`:

```yaml
dependencies:
  orientations: ^0.0.1
```

---

## ⚙️ iOS Setup

1️⃣ **Add the native override in `ios/Runner/AppDelegate.swift`:**

```swift
import Flutter
import UIKit
//new
import orientations
//
@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }


  //new
  override func application(
    _ application: UIApplication,
    supportedInterfaceOrientationsFor window: UIWindow?
  ) -> UIInterfaceOrientationMask {
    return OrientationsPlugin.supportedInterfaceOrientations()
  }
  //
}
```

✅ **This line is required:**  
```swift
return OrientationsPlugin.supportedInterfaceOrientations()
```

---

## 🧩 Usage

```dart
import 'package:flutter/services.dart';
import 'package:orientations/orientations.dart';

void main() async {
  // Allow only Landscape Right & Left on iOS
  await OrientationsPlugin().setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}
```

✅ On Android / other platforms, it automatically falls back to:
```dart
SystemChrome.setPreferredOrientations(...)
```

---

## 🗂️ API

| Method | Description |
| --- | --- |
| `OrientationsPlugin().setPreferredOrientations(List<DeviceOrientation>)` | Set the allowed orientations for the app at runtime.<br>On iOS, this also **forces the first orientation immediately**.|

---

## 💡 Notes

- You **must** override `supportedInterfaceOrientationsFor` in your `AppDelegate.swift` — iOS requires this to allow dynamic orientation changes.
- This plugin uses Flutter’s own `DeviceOrientation` enum — no extra enums!

---

## ✅ Done!

You’ve found the right solution if:  
> _"You can’t set orientation on Flutter → you’re in the right place!"_