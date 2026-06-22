# iOSApp3 - TrailPulse

TrailPulse is a watchOS SwiftUI app for short hikes and outdoor walks. It helps a user start a mini session, track elapsed time and progress, complete suggested trail stops, and save a local activity log.

## Features

- watchOS SwiftUI app generated as a real Xcode project.
- Dashboard with a live session timer, goal progress, and hike status.
- Suggested trail-stop checklist with detail sheets and completion tracking.
- Local session history saved with `UserDefaults` and `Codable`.
- Settings screen with adjustable daily goal and haptic reminder preference.
- Clear Swift comments around persistence and session-state decisions.

## SwiftUI Topics Practiced

- `NavigationStack`, `TabView`, `List`, `Section`, `Form`, and sheets
- `@StateObject`, `@ObservedObject`, `@Published`, `@AppStorage`, and bindings
- `TimelineView` for live watch-friendly timer updates
- `Codable` models and small persistence service
- Reusable views for metric cards, rows, and progress displays

## Project

Open `TrailPulse.xcodeproj` in Xcode and run the `TrailPulse` scheme on a watchOS simulator.

## Build Check

The project can be checked with:

```bash
/usr/bin/xcodebuild -project TrailPulse.xcodeproj -scheme TrailPulse -destination 'generic/platform=watchOS Simulator' -derivedDataPath ./DerivedData build
```
