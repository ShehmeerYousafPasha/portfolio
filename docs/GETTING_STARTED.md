# Getting Started

This Flutter portfolio supports Web, Android, and iOS. GitHub Pages deploys the Web build.

## Prerequisites

- Flutter SDK 3.44.0 or a compatible stable release
- Chrome for local Web development
- Android Studio for Android development
- macOS with Xcode for iOS development

## Run locally

```bash
flutter pub get
flutter run -d chrome
```

To run on a connected Android or iOS device:

```bash
flutter devices
flutter run -d <device-id>
```

## Test the project

```bash
flutter analyze
flutter test
```

## Build for GitHub Pages

The repository is deployed as a project site at `/portfolio/`.

```bash
flutter build web --release --base-href /portfolio/
```

The GitHub Actions workflow performs this build and deploys it whenever changes are pushed to `main`. See [DEPLOYMENT.md](DEPLOYMENT.md) for GitHub setup and post-deployment checks.
