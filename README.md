# IOSApp3 - LocalQuest

Assignment 3 project for iOS Development.

LocalQuest is a SwiftUI scavenger hunt app for a city Chamber of Commerce. It helps players visit 10 participating local businesses, read clues, capture proof photos, and submit their results for discount codes and grand prize eligibility.

## Core Features

- 10 hidden items with participating business names, business categories, clues, and prize hints.
- Card-style SwiftUI screens inspired by the Cards tutorial topic area.
- Camera/photo picker flow to attach proof to each hunt item.
- Progress tracking across all hunt items.
- Online submission simulation with assignment reward rules:
  - 5 or more found: 10% discount code.
  - 7 or more found: 20% discount code.
  - All 10 found: 20% discount code plus entry into the $5000 grand prize draw.

## Project

Open `LocalQuest.xcodeproj` in Xcode and run the `LocalQuest` scheme on an iOS simulator or device. The simulator uses the photo library as a fallback because it does not provide a hardware camera.
