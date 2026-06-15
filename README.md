# IOSApp3 - LocalQuest

Assignment nr 4 project for iOS Development.

LocalQuest is a SwiftUI scavenger hunt app for a city Chamber of Commerce. It helps players visit 10 participating local businesses, read clues, capture proof photos, and submit their results for discount codes and grand prize eligibility.

## Completed Features

- 10 hidden items with participating business names, categories, clues, prize hints, symbols, and accent colors.
- Card-style SwiftUI layouts inspired by the Cards tutorial.
- Camera capture for real devices, with a photo-library fallback for the iOS simulator.
- Proof-photo attachment, retake, and remove flows for each hunt item.
- Persistent saved progress, so attached photos and submission history survive app relaunches.
- Progress tracking with current reward status and next-reward guidance.
- Online submission simulation that calculates the correct reward tier.
- Submission history showing prior results, timestamps, found counts, and discount codes.
- Reset option for replaying the hunt.
- Privacy descriptions for camera and simulator photo-library access.

## Reward Rules

- Find 5 or more items to receive a 10% discount code.
- Find 7 or more items to receive a 20% discount code instead.
- Find all 10 items to receive the 20% discount code and entry into the $5000 grand prize draw.

## SwiftUI Topics Practiced

- Reusable views and card-style components
- `NavigationStack`, `TabView`, `List`, `Section`, and toolbar actions
- `@State`, `@StateObject`, `@EnvironmentObject`, and `@Published`
- Models, view models, and a small persistence service
- Conditional UI for empty states, found items, reward tiers, and loading states
- UIKit integration with `UIViewControllerRepresentable` for camera/photo picking
- Local JSON persistence with `Codable`

## Project

Open `LocalQuest.xcodeproj` in Xcode and run the `LocalQuest` scheme on an iOS simulator or device.

The simulator does not provide a hardware camera, so the app uses the photo library as a fallback there. On a real iPhone, the camera opens directly.

## Build Check

The project was verified with:

```bash
/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild -project LocalQuest.xcodeproj -scheme LocalQuest -destination 'generic/platform=iOS Simulator' -derivedDataPath ./DerivedData build
```
