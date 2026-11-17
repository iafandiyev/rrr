# Tap the Circle

A simple, polished reaction game for iOS built 100% in Swift and SwiftUI.

## Gameplay

- A bright, colorful circle appears at a random position on the screen.
- Tap the circle as quickly as possible. Each successful tap awards **1 point**.
- The circle moves to a new random position after every tap.
- The game lasts **30 seconds**. A countdown timer is shown at the top.
- When time reaches zero, the final score is shown.
- Tap **Play Again** to restart.
- Your **high score** is saved automatically using `UserDefaults`.

## Features

- 100% Swift + SwiftUI, no external dependencies
- Dark minimalist design with a bright gradient target circle
- Smooth spring animations when the circle appears and moves
- Haptic feedback on every successful tap
- Score and countdown timer HUD
- Start screen, gameplay screen, and game-over screen
- High score persisted in `UserDefaults`
- Portrait orientation only
- Responsive layout for all iPhone screens
- Minimum deployment target: iOS 15

## Project structure

```
TapTheCircle.xcodeproj/          # Xcode project
TapTheCircle/
  TapTheCircle/
    App.swift                    # App entry point
    GameManager.swift            # Game state, timer, scoring, high score
    ContentView.swift            # Root view (start / playing / game over)
    StartView.swift              # Welcome screen
    GameView.swift               # Gameplay screen with target circle
    GameOverView.swift           # End-of-game screen
    Info.plist                   # App configuration
.github/
  workflows/
    build.yml                    # GitHub Actions: unsigned IPA build
README.md
```

## Requirements

- Xcode 13 or later
- macOS (to build / run locally)
- iOS 15.0 deployment target

## How to build and run locally

1. Open `TapTheCircle.xcodeproj` in Xcode.
2. Select an iPhone simulator or connect a physical iOS device.
3. Press **Run** (⌘R).

No Apple Developer account is required to run in the simulator.

## GitHub Actions — free unsigned IPA build

A GitHub Actions workflow at `.github/workflows/build.yml` builds an **unsigned IPA** on every push to `main` and on manual dispatch, using GitHub-hosted macOS runners.

- No paid Apple Developer membership required.
- No certificates or provisioning profiles.
- The produced IPA is **unsigned** and is **not directly installable** on a device without re-signing.

### Download the IPA

1. Go to the **Actions** tab of this repository.
2. Select the **Build iOS App (Unsigned IPA)** workflow run.
3. Download the `TapTheCircle-ipa` artifact.
4. Unzip the artifact — it contains `TapTheCircle.ipa`.

## How to install the unsigned IPA with Sideloadly

The IPA produced by GitHub Actions is unsigned. To install it on a physical iPhone, re-sign and sideload it using [Sideloadly](https://sideloadly.io/):

1. Download and install Sideloadly on Windows or macOS.
2. Connect your iPhone to your computer and trust the computer.
3. Open Sideloadly and select your connected device.
4. Drag and drop the unsigned `TapTheCircle.ipa` into Sideloadly.
5. Enter your Apple ID (free Apple ID works) to sign the app.
6. Click **Start** to sideload the app to your iPhone.
7. On your iPhone, go to **Settings → General → VPN & Device Management**, and trust the developer profile for your Apple ID before opening the app.

> ⚠️ Note: A free Apple ID allows sideloading, but apps must be re-installed every 7 days unless you have a paid Apple Developer account.

## License

MIT
