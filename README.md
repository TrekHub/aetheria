# Aetheria 🙏

**Aetheria** is a Flutter-based spiritual companion app that provides AI-generated sermons and daily Bible verses to inspire and guide your spiritual journey. Built with Firebase integration and powered by Google's Vertex AI (Gemini), this app offers personalized spiritual content tailored to your needs.

## ✨ Features

- **🎤 AI-Generated Sermons**: Create personalized sermons based on topics or feelings you're experiencing
- **📖 Daily Bible Verses**: Receive inspirational Bible verses with themes and context
- **🎨 Dynamic SVG Posters**: AI-generated visual content for sermons
- **📱 Cross-Platform**: Supports Android, iOS, macOS, Windows, and Web
- **🔥 Firebase Integration**: Powered by Firebase Core and Vertex AI
- **🎯 State Management**: Uses Provider pattern for efficient state management

## 🚀 Getting Started

### Prerequisites

Before setting up the project, ensure you have the following installed:

- **Flutter SDK** (3.8.1 or higher)
- **Dart SDK** (included with Flutter)
- **Android Studio** (for Android development)
- **Xcode** (for iOS/macOS development - Mac only)
- **Firebase CLI**
- **Node.js** (for Firebase CLI)
- **Git**

### Flutter Installation

1. Download and install Flutter from the [official website](https://docs.flutter.dev/get-started/install)
2. Add Flutter to your system PATH
3. Run `flutter doctor` to verify installation and resolve any issues

### Firebase CLI Installation

```bash
# Install Firebase CLI via npm
npm install -g firebase-tools

# Login to Firebase
firebase login
```

## 🛠️ Project Setup

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/aetheria.git
cd aetheria
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Firebase Setup

This is the most critical part of the setup process. Follow these steps carefully:

#### Step 3.1: Create Firebase Project

1. Go to the [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project" or "Add project"
3. Enter your project name (e.g., "aetheria-your-name")
4. Choose whether to enable Google Analytics (recommended)
5. Select or create a Google Analytics account
6. Click "Create project"

#### Step 3.2: Enable Required Services

In your Firebase project console:

1. **Enable Vertex AI API**:
   - Go to "Build" > "Vertex AI"
   - Enable the Vertex AI API
   - Make sure the Gemini models are available in your region

2. **Enable Authentication** (Optional but recommended):
   - Go to "Build" > "Authentication"
   - Click "Get started"
   - Enable your preferred sign-in methods

3. **Configure Project Settings**:
   - Go to "Project Settings" (gear icon)
   - Note down your Project ID

#### Step 3.3: Add Platforms to Firebase

You need to add each platform you want to support:

**For Android:**
1. In Firebase Console, click "Add app" > Android icon
2. Enter package name: `com.example.aetheria` (or customize it)
3. Enter app nickname: "Aetheria Android"
4. Add SHA-1 key (optional for development)
5. Download `google-services.json`
6. Place it in `android/app/google-services.json`

**For iOS:**
1. Click "Add app" > iOS icon
2. Enter bundle ID: `com.example.aetheria` (or customize it)
3. Enter app nickname: "Aetheria iOS"
4. Download `GoogleService-Info.plist`
5. Place it in `ios/Runner/GoogleService-Info.plist`

**For macOS:**
1. Click "Add app" > iOS icon (use the same process)
2. Use the same bundle ID as iOS
3. Download `GoogleService-Info.plist`
4. Place it in `macos/Runner/GoogleService-Info.plist`

**For Web:**
1. Click "Add app" > Web icon
2. Enter app nickname: "Aetheria Web"
3. Copy the Firebase config object

#### Step 3.4: Generate Firebase Options

Use the FlutterFire CLI to automatically generate platform configurations:

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase for your project
flutterfire configure
```

This will:
- Generate `lib/firebase_options.dart`
- Update platform-specific configuration files
- Create or update `firebase.json`

**Important**: When prompted, select your Firebase project and choose all platforms you want to support.

#### Step 3.5: Update Package Name (Optional)

If you want to use a custom package name instead of `com.example.aetheria`:

**Android** (`android/app/build.gradle.kts`):
```kotlin
defaultConfig {
    applicationId = "com.yourname.aetheria" // Change this
    // ... rest of config
}
```

**iOS** (`ios/Runner/Info.plist`):
```xml
<key>CFBundleIdentifier</key>
<string>com.yourname.aetheria</string>
```

**macOS** (`macos/Runner/Info.plist`):
```xml
<key>CFBundleIdentifier</key>
<string>com.yourname.aetheria</string>
```

### 4. Update Firebase Configuration

After running `flutterfire configure`, verify that `lib/firebase_options.dart` was created with your project details.

### 5. Platform-Specific Setup

#### Android Setup

1. Ensure minimum SDK version in `android/app/build.gradle.kts`:
   ```kotlin
   defaultConfig {
       minSdk = 21  // Firebase requires minimum SDK 21
   }
   ```

2. Verify that the Google Services plugin is applied in `android/app/build.gradle.kts`:
   ```kotlin
   plugins {
       id("com.google.gms.google-services")
   }
   ```

#### iOS Setup

1. Open `ios/Runner.xcworkspace` in Xcode
2. Ensure minimum deployment target is iOS 12.0 or higher
3. Add `GoogleService-Info.plist` to the Runner target in Xcode

#### macOS Setup

1. Open `macos/Runner.xcworkspace` in Xcode
2. Ensure minimum deployment target is macOS 10.15 or higher
3. Add `GoogleService-Info.plist` to the Runner target in Xcode

## 🎯 Running the Application

### Development Mode

```bash
# Run on connected device/emulator
flutter run

# Run on specific platform
flutter run -d chrome          # Web
flutter run -d macos          # macOS
flutter run -d android        # Android
flutter run -d ios           # iOS
```

### Build for Production

```bash
# Android APK
flutter build apk --release

# Android App Bundle (recommended for Play Store)
flutter build appbundle --release

# iOS
flutter build ios --release

# macOS
flutter build macos --release

# Web
flutter build web --release
```

## 🔧 Configuration

### Firebase Configuration Files

The following files contain Firebase configuration and should be properly set up:

- `lib/firebase_options.dart` - Auto-generated Firebase configuration
- `android/app/google-services.json` - Android Firebase configuration
- `ios/Runner/GoogleService-Info.plist` - iOS Firebase configuration
- `macos/Runner/GoogleService-Info.plist` - macOS Firebase configuration
- `firebase.json` - Firebase project configuration

### Environment Variables

For production deployments, consider using environment-specific configurations:

1. Create different Firebase projects for development, staging, and production
2. Use different configuration files for each environment
3. Implement environment-specific builds

## 📱 App Architecture

### Project Structure

```
lib/
├── firebase_options.dart      # Auto-generated Firebase config
├── main.dart                  # App entry point
├── providers/                 # State management
│   ├── daily_verse_provider.dart
│   └── sermon_provider.dart
├── screens/                   # UI screens
│   ├── dashboard_screen.dart
│   ├── sermon_display_screen.dart
│   ├── sermon_form_screen.dart
│   └── splash_screen.dart
└── service/                   # Business logic
    ├── daily_verse_service.dart
    └── sermon_service.dart
```

### Key Dependencies

- `firebase_core: ^4.1.0` - Firebase initialization
- `firebase_ai: ^3.2.0` - Vertex AI integration
- `provider: ^6.1.2` - State management
- `flutter_svg: ^2.0.15` - SVG rendering
- `path_provider: ^2.1.5` - File system access

## 🚨 Troubleshooting

### Common Issues

1. **Firebase not initialized**
   - Ensure `Firebase.initializeApp()` is called in `main()`
   - Verify `firebase_options.dart` exists and is correct

2. **Platform-specific build errors**
   - Run `flutter clean && flutter pub get`
   - Ensure all platform configurations are properly set up

3. **Vertex AI API errors**
   - Check that Vertex AI is enabled in Firebase Console
   - Verify your Firebase project has billing enabled
   - Ensure Gemini models are available in your region

4. **Package name conflicts**
   - Ensure package names match between Firebase config and platform files
   - Run `flutterfire configure` again if you change package names

### Debug Commands

```bash
# Check Flutter installation and dependencies
flutter doctor -v

# Clean and rebuild
flutter clean
flutter pub get
flutter pub deps

# Check for outdated packages
flutter pub outdated

# Analyze code for issues
flutter analyze
```

## 🤝 Contributing

We welcome contributions! Here's how to get started:

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/amazing-feature`
3. **Make your changes**
4. **Test thoroughly** on multiple platforms
5. **Commit your changes**: `git commit -m 'Add amazing feature'`
6. **Push to your branch**: `git push origin feature/amazing-feature`
7. **Open a Pull Request**

### Development Guidelines

- Follow Flutter/Dart style guidelines
- Add comments for complex logic
- Update documentation for new features
- Test on multiple platforms when possible
- Ensure Firebase integration works correctly

### Code Style

This project follows the official [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style). Use the following commands to maintain code quality:

```bash
# Format code
dart format .

# Analyze code
flutter analyze

# Run tests
flutter test
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙋‍♂️ Support

If you encounter any issues or have questions:

1. **Check the troubleshooting section** above
2. **Search existing issues** on GitHub
3. **Create a new issue** with detailed information about your problem
4. **Include platform information** and error messages

## 🌟 Acknowledgments

- **Flutter Team** for the amazing framework
- **Firebase Team** for the backend services
- **Google** for Vertex AI and Gemini models
- **Contributors** who help improve this project

---

**Happy coding and may your spiritual journey be blessed! 🙏**
