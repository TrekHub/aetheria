# Firebase Setup Guide for Aetheria

This guide provides detailed steps for setting up Firebase for the Aetheria project. Follow these instructions carefully to ensure proper integration with all Firebase services.

## 📋 Prerequisites

Before starting, ensure you have:

- A Google account
- Firebase CLI installed (`npm install -g firebase-tools`)
- FlutterFire CLI installed (`dart pub global activate flutterfire_cli`)
- Access to Google Cloud Platform (for Vertex AI)

## 🔥 Step-by-Step Firebase Setup

### 1. Create Firebase Project

1. **Go to Firebase Console**: Visit [https://console.firebase.google.com/](https://console.firebase.google.com/)

2. **Create New Project**:

   - Click "Create a project" or "Add project"
   - Enter project name: `aetheria-[your-suffix]` (e.g., `aetheria-john-doe`)
   - Choose whether to enable Google Analytics (recommended: **Yes**)
   - Select or create a Google Analytics account
   - Review and accept terms
   - Click "Create project"

3. **Wait for project creation** (usually takes 1-2 minutes)

### 2. Enable Required APIs and Services

#### 2.1 Enable Vertex AI

1. In Firebase Console, go to **"Build" > "Vertex AI"**
2. Click **"Get Started"**
3. **Enable Vertex AI API** if prompted
4. **Enable billing** on your Google Cloud Project (required for Vertex AI)
   - Go to Google Cloud Console
   - Navigate to "Billing"
   - Link a payment method (you get $300 free credits)
5. **Verify Gemini model availability** in your region

#### 2.2 Enable Authentication (Optional but Recommended)

1. Go to **"Build" > "Authentication"**
2. Click **"Get started"**
3. **Choose sign-in methods**:
   - Email/Password (most common)
   - Google Sign-In (recommended)
   - Anonymous (for guest users)
4. **Configure authorized domains** if needed

#### 2.3 Enable Firestore (Optional - for future features)

1. Go to **"Build" > "Firestore Database"**
2. Click **"Create database"**
3. **Choose security rules**:
   - Start in test mode (for development)
   - Start in production mode (for production)
4. **Select location** (choose closest to your users)

### 3. Add Apps to Firebase Project

You need to register each platform (Android, iOS, Web, etc.) with Firebase:

#### 3.1 Android App

1. **Click the Android icon** in project overview
2. **Enter package name**: `com.example.aetheria`
   - ⚠️ **Important**: This must match your Android app's package name
   - To customize: change in `android/app/build.gradle.kts` → `applicationId`
3. **Enter app nickname**: `Aetheria Android`
4. **Add SHA-1 certificate** (optional for development):
   ```bash
   # Get debug certificate SHA-1
   keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
   ```
5. **Download `google-services.json`**
6. **Place file** in `android/app/google-services.json`

#### 3.2 iOS App

1. **Click the iOS icon** in project overview
2. **Enter bundle ID**: `com.example.aetheria`
   - ⚠️ **Important**: This must match your iOS app's bundle identifier
   - To customize: change in `ios/Runner/Info.plist` → `CFBundleIdentifier`
3. **Enter app nickname**: `Aetheria iOS`
4. **Download `GoogleService-Info.plist`**
5. **Add to Xcode project**:
   - Open `ios/Runner.xcworkspace` in Xcode
   - Drag `GoogleService-Info.plist` to Runner folder in Xcode
   - Ensure "Copy items if needed" is checked
   - Ensure "Add to target: Runner" is checked

#### 3.3 macOS App

1. **Click the iOS icon** (same process as iOS)
2. **Use same bundle ID** as iOS: `com.example.aetheria`
3. **Enter app nickname**: `Aetheria macOS`
4. **Download `GoogleService-Info.plist`**
5. **Add to Xcode project**:
   - Open `macos/Runner.xcworkspace` in Xcode
   - Drag `GoogleService-Info.plist` to Runner folder in Xcode
   - Follow same steps as iOS

#### 3.4 Web App

1. **Click the Web icon** (`</>`) in project overview
2. **Enter app nickname**: `Aetheria Web`
3. **Choose hosting setup**: No (unless you want Firebase Hosting)
4. **Copy Firebase config object** (you'll use this later)
5. **Click "Continue to console"**

### 4. Configure FlutterFire

This step automatically generates platform configurations:

1. **Run FlutterFire configuration**:

   ```bash
   flutterfire configure
   ```

2. **Select your Firebase project** from the list

3. **Choose platforms** to configure:

   - ✅ Android
   - ✅ iOS
   - ✅ macOS
   - ✅ Web
   - ✅ Windows (if you plan to support it)

4. **Review generated files**:
   - `lib/firebase_options.dart` ✅ Generated
   - `firebase.json` ✅ Created/Updated
   - Platform configs ✅ Updated

### 5. Verify Configuration Files

#### Check `lib/firebase_options.dart`

```dart
// This file should be auto-generated and look similar to:
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      // ... other platforms
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'your-android-api-key',
    appId: 'your-android-app-id',
    messagingSenderId: 'your-sender-id',
    projectId: 'your-project-id',
    storageBucket: 'your-project.firebasestorage.app',
  );
  // ... other platform configs
}
```

#### Verify Platform Files

**Android** - `android/app/google-services.json`:

```json
{
  "project_info": {
    "project_number": "your-project-number",
    "project_id": "your-project-id"
  },
  "client": [
    {
      "client_info": {
        "mobilesdk_app_id": "your-app-id",
        "android_client_info": {
          "package_name": "com.example.aetheria"
        }
      }
    }
  ]
}
```

**iOS/macOS** - `ios/Runner/GoogleService-Info.plist`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>PROJECT_ID</key>
    <string>your-project-id</string>
    <key>BUNDLE_ID</key>
    <string>com.example.aetheria</string>
    <!-- ... other keys -->
</dict>
</plist>
```

### 6. Update Build Configurations

#### Android - `android/app/build.gradle.kts`

Ensure these configurations are present:

```kotlin
plugins {
    id("com.android.application")
    id("com.google.gms.google-services") // ✅ Firebase plugin
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.aetheria"
    compileSdk = flutter.compileSdkVersion

    defaultConfig {
        applicationId = "com.example.aetheria" // ✅ Must match Firebase
        minSdk = 21 // ✅ Firebase requires minimum API 21
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }
}
```

#### Android - `android/build.gradle.kts`

Ensure Google Services plugin is available:

```kotlin
buildscript {
    ext.kotlin_version = '1.7.10'
    repositories {
        google() // ✅ Required for Firebase
        mavenCentral()
    }
    dependencies {
        classpath("com.google.gms:google-services:4.3.15") // ✅ Firebase plugin
    }
}
```

### 7. Test Firebase Integration

1. **Run the app**:

   ```bash
   flutter run
   ```

2. **Check for initialization errors** in console output

3. **Verify Firebase is working**:
   - App should start without Firebase errors
   - Check Firebase Console for connected devices
   - Test sermon generation (requires Vertex AI)

### 8. Configure Vertex AI Permissions

1. **Go to Google Cloud Console**: [https://console.cloud.google.com/](https://console.cloud.google.com/)

2. **Select your project**

3. **Enable Vertex AI API**:

   - Go to "APIs & Services" > "Library"
   - Search for "Vertex AI API"
   - Click "Enable"

4. **Set up authentication**:

   - Firebase handles this automatically
   - Ensure your Firebase project has billing enabled

5. **Test Vertex AI**:
   - Try generating a sermon in the app
   - Check for API quota limits if you get errors

### 9. Security Configuration

#### Firestore Security Rules (if using Firestore)

```javascript
// firestore.rules
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow authenticated users to read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }

    // Public read for shared content (like daily verses)
    match /daily_verses/{document} {
      allow read: if true;
      allow write: if request.auth != null;
    }
  }
}
```

#### Firebase Authentication Rules

Configure in Firebase Console > Authentication > Settings:

- **Authorized domains**: Add your domains
- **Password policy**: Set strength requirements
- **User management**: Configure user deletion, etc.

### 10. Environment-Specific Configuration

For production apps, consider multiple environments:

#### Development Environment

```bash
# Use separate Firebase project for development
flutterfire configure --project=aetheria-dev
```

#### Production Environment

```bash
# Use different Firebase project for production
flutterfire configure --project=aetheria-prod
```

## 🔧 Troubleshooting

### Common Issues and Solutions

#### 1. "FirebaseOptions have not been configured"

**Solution**: Run `flutterfire configure` and ensure `lib/firebase_options.dart` exists.

#### 2. "Google Services plugin not applied"

**Solution**: Add to `android/app/build.gradle.kts`:

```kotlin
plugins {
    id("com.google.gms.google-services")
}
```

#### 3. "Package name mismatch"

**Solution**: Ensure package names match in:

- Firebase Console app registration
- `android/app/build.gradle.kts` → `applicationId`
- `google-services.json` → `package_name`

#### 4. "Vertex AI API not enabled"

**Solution**:

1. Go to Google Cloud Console
2. Enable Vertex AI API
3. Ensure billing is enabled
4. Check regional availability

#### 5. "iOS build fails with Firebase"

**Solution**:

1. Ensure `GoogleService-Info.plist` is added to Xcode project
2. Clean build folder: `flutter clean`
3. Delete `ios/Pods` and run `cd ios && pod install`

#### 6. "Web build fails"

**Solution**:

1. Ensure Firebase is initialized before app starts
2. Check browser console for errors
3. Verify web configuration in `firebase_options.dart`

### Debug Commands

```bash
# Check Firebase CLI status
firebase --version
firebase projects:list

# Check FlutterFire CLI
dart pub global list
flutterfire --version

# Verify Flutter/Firebase integration
flutter doctor -v
flutter pub deps

# Clean and rebuild
flutter clean
flutter pub get
cd ios && pod install # iOS only
cd android && ./gradlew clean # Android only
```

## 📊 Monitoring and Analytics

### Firebase Analytics Setup

1. **Enable Analytics** in Firebase Console
2. **Add custom events** for user actions:
   ```dart
   // In your Flutter app
   FirebaseAnalytics.instance.logEvent(
     name: 'sermon_generated',
     parameters: {'topic': topicName},
   );
   ```

### Performance Monitoring

1. **Add Performance Monitoring**:

   ```yaml
   # pubspec.yaml
   dependencies:
     firebase_performance: ^0.9.3+6
   ```

2. **Initialize in app**:

   ```dart
   import 'package:firebase_performance/firebase_performance.dart';

   final trace = FirebasePerformance.instance.newTrace('sermon_generation');
   await trace.start();
   // ... your code
   await trace.stop();
   ```

## 🚀 Production Deployment

### Before Going Live

1. **Switch to production Firebase project**
2. **Update security rules**
3. **Enable proper authentication**
4. **Set up monitoring and alerts**
5. **Configure proper error reporting**
6. **Test all Firebase services thoroughly**

### Billing Considerations

- **Vertex AI**: Pay-per-request model
- **Firestore**: Free tier available
- **Authentication**: Free for most use cases
- **Hosting**: Free tier available

Monitor usage in Firebase Console and Google Cloud Console to avoid unexpected charges.

---

## 📞 Support

If you encounter issues with Firebase setup:

1. Check the [Firebase Documentation](https://firebase.google.com/docs)
2. Review [FlutterFire Documentation](https://firebase.flutter.dev/)
3. Search existing GitHub issues
4. Create a detailed issue report

**Happy Firebase integration! 🔥**
