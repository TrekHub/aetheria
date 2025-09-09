# Deployment Guide

This guide covers how to build and deploy Aetheria across different platforms and environments.

## 📱 Platform-Specific Deployment

### Android Deployment

#### Development Build (APK)

```bash
# Build debug APK for testing
flutter build apk --debug

# Build release APK
flutter build apk --release

# Build with specific flavor (if configured)
flutter build apk --release --flavor production
```

#### Google Play Store (AAB)

```bash
# Build Android App Bundle (recommended for Play Store)
flutter build appbundle --release

# Build with obfuscation (recommended for production)
flutter build appbundle --release --obfuscate --split-debug-info=build/debug-info
```

#### Play Store Preparation

1. **Create signing key**:
   ```bash
   keytool -genkey -v -keystore ~/aetheria-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias aetheria
   ```

2. **Configure `android/key.properties`**:
   ```properties
   storePassword=your_store_password
   keyPassword=your_key_password
   keyAlias=aetheria
   storeFile=/path/to/aetheria-key.jks
   ```

3. **Update `android/app/build.gradle.kts`**:
   ```kotlin
   android {
       signingConfigs {
           release {
               keyAlias = keystoreProperties['keyAlias']
               keyPassword = keystoreProperties['keyPassword']
               storeFile = keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
               storePassword = keystoreProperties['storePassword']
           }
       }
       buildTypes {
           release {
               signingConfig = signingConfigs.release
           }
       }
   }
   ```

#### Play Store Assets

Create the following assets for Play Store:

- **App Icon**: 512x512 PNG
- **Feature Graphic**: 1024x500 PNG
- **Screenshots**: Various device sizes
- **App Description**: Compelling description highlighting AI features
- **Privacy Policy**: Required for Firebase integration

### iOS Deployment

#### Development Build

```bash
# Build for iOS device
flutter build ios --release

# Build for iOS simulator
flutter build ios --debug --simulator
```

#### App Store Connect

1. **Open in Xcode**:
   ```bash
   open ios/Runner.xcworkspace
   ```

2. **Configure signing**:
   - Select Runner project
   - Go to Signing & Capabilities
   - Select your development team
   - Choose appropriate provisioning profile

3. **Archive the app**:
   - Product → Archive
   - Upload to App Store Connect

4. **App Store Connect setup**:
   - Add app metadata
   - Upload screenshots
   - Configure pricing
   - Submit for review

#### Required iOS Configurations

**Info.plist updates** (`ios/Runner/Info.plist`):
```xml
<!-- Camera access (if needed for future features) -->
<key>NSCameraUsageDescription</key>
<string>This app needs camera access to capture images for sermons.</string>

<!-- Microphone access (if needed) -->
<key>NSMicrophoneUsageDescription</key>
<string>This app needs microphone access for voice features.</string>

<!-- Internet access -->
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

### macOS Deployment

#### Build for macOS

```bash
# Build macOS app
flutter build macos --release

# Build with codesigning
flutter build macos --release --codesign
```

#### Mac App Store

1. **Configure macOS signing**:
   - Open `macos/Runner.xcworkspace`
   - Configure signing certificates
   - Set appropriate entitlements

2. **Required entitlements** (`macos/Runner/Release.entitlements`):
   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
   <plist version="1.0">
   <dict>
       <key>com.apple.security.app-sandbox</key>
       <true/>
       <key>com.apple.security.network.client</key>
       <true/>
   </dict>
   </plist>
   ```

### Web Deployment

#### Build for Web

```bash
# Build web app
flutter build web --release

# Build with web renderer
flutter build web --web-renderer canvaskit --release
```

#### Firebase Hosting

1. **Initialize Firebase Hosting**:
   ```bash
   firebase init hosting
   ```

2. **Configure `firebase.json`**:
   ```json
   {
     "hosting": {
       "public": "build/web",
       "ignore": [
         "firebase.json",
         "**/.*",
         "**/node_modules/**"
       ],
       "rewrites": [
         {
           "source": "**",
           "destination": "/index.html"
         }
       ]
     }
   }
   ```

3. **Deploy**:
   ```bash
   flutter build web --release
   firebase deploy --only hosting
   ```

#### GitHub Pages

1. **Create `.github/workflows/deploy.yml`**:
   ```yaml
   name: Deploy to GitHub Pages
   
   on:
     push:
       branches: [ main ]
   
   jobs:
     build:
       runs-on: ubuntu-latest
       
       steps:
       - uses: actions/checkout@v3
       - uses: subosito/flutter-action@v2
         with:
           flutter-version: '3.19.0'
       - run: flutter pub get
       - run: flutter build web --base-href "/aetheria/"
       - uses: peaceiris/actions-gh-pages@v3
         with:
           github_token: ${{ secrets.GITHUB_TOKEN }}
           publish_dir: ./build/web
   ```

### Windows Deployment

#### Build for Windows

```bash
# Build Windows app
flutter build windows --release
```

#### Microsoft Store

1. **Create MSIX package**:
   ```bash
   # Add to pubspec.yaml
   dependencies:
     msix: ^3.16.6
   
   # Configure MSIX
   flutter pub run msix:create
   ```

2. **Configure `pubspec.yaml`**:
   ```yaml
   msix_config:
     display_name: Aetheria
     publisher_display_name: Your Name
     identity_name: com.yourname.aetheria
     msix_version: 1.0.0.0
     description: AI-powered spiritual companion app
     ```

## 🔧 Environment Configuration

### Development Environment

Create environment-specific configurations:

```dart
// lib/config/environment.dart
abstract class Environment {
  static const String dev = 'development';
  static const String prod = 'production';
  
  static const String current = String.fromEnvironment('ENV', defaultValue: dev);
  
  static bool get isDevelopment => current == dev;
  static bool get isProduction => current == prod;
}
```

### Firebase Environment Setup

#### Development Firebase Project

```bash
# Configure for development
flutterfire configure --project=aetheria-dev
```

#### Production Firebase Project

```bash
# Configure for production
flutterfire configure --project=aetheria-prod
```

### Build Scripts

Create build scripts for different environments:

**`scripts/build_dev.sh`**:
```bash
#!/bin/bash
echo "Building for development..."
flutter build apk --debug --dart-define=ENV=development
```

**`scripts/build_prod.sh`**:
```bash
#!/bin/bash
echo "Building for production..."
flutter build apk --release --dart-define=ENV=production --obfuscate --split-debug-info=build/debug-info
```

## 🚀 CI/CD Pipeline

### GitHub Actions

Create `.github/workflows/ci.yml`:

```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    - uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.19.0'
    
    - name: Install dependencies
      run: flutter pub get
    
    - name: Analyze code
      run: flutter analyze
    
    - name: Run tests
      run: flutter test
    
    - name: Build APK
      run: flutter build apk --debug
    
    - name: Upload APK
      uses: actions/upload-artifact@v3
      with:
        name: debug-apk
        path: build/app/outputs/flutter-apk/app-debug.apk

  deploy:
    needs: test
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    
    steps:
    - uses: actions/checkout@v3
    - uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.19.0'
    
    - name: Install dependencies
      run: flutter pub get
    
    - name: Build web
      run: flutter build web --release
    
    - name: Deploy to Firebase Hosting
      uses: FirebaseExtended/action-hosting-deploy@v0
      with:
        repoToken: '${{ secrets.GITHUB_TOKEN }}'
        firebaseServiceAccount: '${{ secrets.FIREBASE_SERVICE_ACCOUNT }}'
        projectId: your-firebase-project-id
```

### Codemagic Setup

Create `codemagic.yaml`:

```yaml
workflows:
  android-workflow:
    name: Android Workflow
    max_build_duration: 120
    instance_type: mac_mini_m1
    environment:
      android_signing:
        - aetheria_keystore
      groups:
        - firebase_credentials
      flutter: stable
    scripts:
      - name: Get Flutter packages
        script: flutter packages pub get
      - name: Build Android
        script: flutter build appbundle --release
    artifacts:
      - build/**/outputs/**/*.aab
    publishing:
      google_play:
        credentials: $GCLOUD_SERVICE_ACCOUNT_CREDENTIALS
        track: internal

  ios-workflow:
    name: iOS Workflow
    max_build_duration: 120
    instance_type: mac_mini_m1
    environment:
      ios_signing:
        distribution_type: app_store
        bundle_identifier: com.example.aetheria
      flutter: stable
    scripts:
      - name: Get Flutter packages
        script: flutter packages pub get
      - name: Build iOS
        script: flutter build ipa --release
    artifacts:
      - build/ios/ipa/*.ipa
    publishing:
      app_store_connect:
        auth: integration
```

## 📊 Performance Optimization

### Build Optimization

```bash
# Build with tree-shaking and minification
flutter build web --release --tree-shake-icons

# Build with split-debug-info
flutter build apk --release --split-debug-info=build/debug-info

# Build with obfuscation
flutter build apk --release --obfuscate --split-debug-info=build/debug-info
```

### Asset Optimization

1. **Optimize images**:
   ```bash
   # Install imagemagick
   brew install imagemagick
   
   # Compress images
   find assets/images -name "*.png" -exec convert {} -quality 85 {} \;
   ```

2. **Use appropriate image formats**:
   - PNG for images with transparency
   - JPEG for photos
   - SVG for icons and simple graphics

### Bundle Size Analysis

```bash
# Analyze APK size
flutter build apk --analyze-size

# Analyze bundle size
flutter build appbundle --analyze-size
```

## 🔒 Security Considerations

### Code Obfuscation

```bash
# Build with obfuscation
flutter build apk --release --obfuscate --split-debug-info=build/debug-info
```

### API Key Security

1. **Use environment variables**:
   ```dart
   const String apiKey = String.fromEnvironment('API_KEY');
   ```

2. **Build with environment variables**:
   ```bash
   flutter build apk --release --dart-define=API_KEY=your_actual_key
   ```

### Firebase Security Rules

Update Firebase security rules for production:

```javascript
// firestore.rules
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

## 🔍 Monitoring and Analytics

### Crashlytics Setup

```yaml
# pubspec.yaml
dependencies:
  firebase_crashlytics: ^3.4.8

# Initialize in main.dart
await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
```

### Performance Monitoring

```dart
// Track custom performance metrics
final trace = FirebasePerformance.instance.newTrace('sermon_generation');
await trace.start();
// ... your code
await trace.stop();
```

## 📱 Store Submission

### Google Play Store Checklist

- [ ] App signed with release key
- [ ] Proper app description and metadata
- [ ] Screenshots for different device sizes
- [ ] Privacy policy URL
- [ ] Content rating questionnaire completed
- [ ] Target API level requirements met

### Apple App Store Checklist

- [ ] App signed with distribution certificate
- [ ] App metadata and screenshots
- [ ] Privacy policy and terms of service
- [ ] App Review Guidelines compliance
- [ ] TestFlight testing completed

### Microsoft Store Checklist

- [ ] MSIX package created
- [ ] Store listing information
- [ ] Age rating and content descriptors
- [ ] Privacy policy
- [ ] App certification requirements met

## 🚨 Troubleshooting Deployment

### Common Issues

1. **Gradle build failures**:
   ```bash
   cd android
   ./gradlew clean
   cd ..
   flutter clean
   flutter pub get
   ```

2. **iOS build issues**:
   ```bash
   cd ios
   pod deintegrate
   pod install
   cd ..
   flutter clean
   flutter pub get
   ```

3. **Web build issues**:
   ```bash
   flutter clean
   flutter pub get
   flutter build web --web-renderer canvaskit
   ```

### Debug Commands

```bash
# Verbose build output
flutter build apk --release --verbose

# Check build artifacts
flutter build apk --analyze-size

# Verify signing
jarsigner -verify -verbose -certs build/app/outputs/flutter-apk/app-release.apk
```

---

This deployment guide should help you successfully deploy Aetheria across all supported platforms. Remember to test thoroughly on each platform before production deployment!
