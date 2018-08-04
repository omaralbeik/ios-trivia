# iOS Trivia
Simple Trivia iOS App for demo purposes.

## Before you start
This project uses some [thrid party libraries](https://github.com/omaralbeik/ios-trivia/blob/master/Podfile) that requires [Xcode](https://developer.apple.com/xcode/) and [Cocoapods](https://cocoapods.org/) to add before building, if you don't have them installed, please do so before proceeding.

## Requirements
- Xcode 9+
- iOS 9.0+

## Installation
1. Download or clone the project
2. Navigate to the project directory and install thrid-party libraries
```bash
pod install
```
3. Open [iOS Trivia.xcworkspace](https://github.com/omaralbeik/ios-trivia/tree/master/iOS%20Trivia.xcworkspace) in Xcode 9.
4. Run the project to iOS simulator or your real device.

## Technical Details
- Programming language: Swift 4.1
- Deployment target: iOS 9+
- Development environment: Xcode 9.4 on macOS 10.13
- Used structure: MVC
- Backend provider: Firebase

## The Models

#### Question Model:
```json
{
      "id": "q1",
      "text": "...",
      "duration": 15,
      "points": 30,
      "answers": [
        {
          "text": "..",
          "is_correct": true
        },
        ..
      ]
    }
```

#### User Model
```json
{
    "email": "...",
    "id": "...",
    "points": {
        "question_id": "points",
        ..
    }
}
```

## Technical Considerations
- This is a **demo project** and not intended to be used at scale or publised on the AppStore.
- Basic UI and focus on code, I'm not a UI/UX designer :)
- No Storyboard or Interface Builder, [SnapKit](https://github.com/SnapKit/SnapKit) for autolayout.
- Fireboase SDK was not used to demonstrate writing a networking layer using [Moya](https://github.com/Moya/Moya)
- [SwiftLint](https://github.com/realm/SwiftLint) is used to keep the code consistance and clean.

## License
MIT license. See [LICENSE](https://github.com/omaralbeik/ios-trivia/blob/master/LICENSE) for more information.
