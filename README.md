# 🌟 Introduction

Architectural pattern **Business Logic Component (BLoC)**

# 🚀 Getting Started

## 1. Generate code

```dart
flutter pub get
flutter packages pub run build_runner build
flutter gen-l10n
```

## 2. Run app

```dart
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
flutter run --flavor="development" --dart-define-from-file="env-dev.json"
```

# 🧪 Build and Test

## 1. Andoird

```dart
flutter build apk --release --flavor="development" --dart-define-from-file="env-dev.json"
flutter build apk --release --flavor="production" --dart-define-from-file="env-prod.json"
```

## 2. IOS

```dart
flutter build ipa --release --flavor="development" --dart-define-from-file="env-dev.json"
flutter build ipa --release --flavor="production" --dart-define-from-file="env-prod.json"
```

## 3. Test

```dart
flutter test
```
