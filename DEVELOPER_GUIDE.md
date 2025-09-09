# Developer Quick Start

Welcome to Aetheria! This guide will get you up and running quickly.

## ⚡ Quick Setup (5 minutes)

1. **Clone and Install**:
   ```bash
   git clone https://github.com/your-username/aetheria.git
   cd aetheria
   flutter pub get
   ```

2. **Set up Firebase**:
   ```bash
   # Install Firebase CLI
   npm install -g firebase-tools
   firebase login
   
   # Install FlutterFire CLI
   dart pub global activate flutterfire_cli
   
   # Configure your project (you'll need your own Firebase project)
   flutterfire configure
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

## 🎯 What is Aetheria?

Aetheria is an AI-powered spiritual companion app that provides:
- **🎤 Personalized Sermons**: AI-generated sermons based on your topics/feelings
- **📖 Daily Bible Verses**: Inspirational verses with themes and context
- **🎨 Visual Content**: AI-generated SVG posters for sermons
- **📱 Cross-Platform**: Android, iOS, macOS, Windows, Web

## 🛠️ Tech Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Firebase (Firestore, Vertex AI)
- **AI**: Google Gemini 2.5 Flash via Vertex AI
- **State Management**: Provider
- **Platforms**: Android, iOS, macOS, Windows, Web

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point & Firebase init
├── firebase_options.dart        # Auto-generated Firebase config
├── providers/                   # State management
│   ├── daily_verse_provider.dart
│   └── sermon_provider.dart
├── screens/                     # UI screens
│   ├── splash_screen.dart
│   ├── dashboard_screen.dart
│   ├── sermon_form_screen.dart
│   └── sermon_display_screen.dart
└── service/                     # Business logic & AI calls
    ├── daily_verse_service.dart
    └── sermon_service.dart
```

## 🔥 Firebase Setup Requirements

You'll need to create your own Firebase project with:

1. **Vertex AI enabled** (for AI-generated content)
2. **Billing enabled** (required for Vertex AI)
3. **Apps configured** for your target platforms

See [FIREBASE_SETUP.md](FIREBASE_SETUP.md) for detailed instructions.

## 🚀 Development Commands

```bash
# Run on different platforms
flutter run -d chrome          # Web
flutter run -d macos          # macOS  
flutter run -d android        # Android
flutter run -d ios           # iOS

# Build for release
flutter build apk --release              # Android APK
flutter build appbundle --release        # Android AAB
flutter build ios --release              # iOS
flutter build web --release              # Web
flutter build macos --release            # macOS

# Development tools
flutter clean                   # Clean build cache
flutter pub get                # Get dependencies
flutter analyze                # Analyze code
flutter test                   # Run tests
dart format .                  # Format code
```

## 🎨 Key Features Implementation

### AI Sermon Generation
```dart
// service/sermon_service.dart
final model = FirebaseAI.vertexAI().generativeModel(model: 'gemini-2.5-flash');
final response = await model.generateContent(prompt);
```

### Daily Bible Verses
```dart
// service/daily_verse_service.dart  
Future<Map<String, dynamic>> generateDailyVerse() async {
  // AI generates inspirational Bible verse with theme
}
```

### State Management
```dart
// Uses Provider pattern for reactive UI updates
ChangeNotifierProvider(create: (context) => SermonProvider())
```

## 🧪 Testing the App

1. **Generate Sermon**:
   - Open app → tap "Create Sermon"
   - Enter a topic (e.g., "hope", "anxiety", "gratitude")
   - AI generates personalized sermon with Bible verse

2. **Daily Verse**:
   - View dashboard for daily inspirational Bible verse
   - Refresh to get new verse

## ⚠️ Common Setup Issues

1. **"FirebaseOptions not configured"**:
   - Run `flutterfire configure`
   - Ensure `lib/firebase_options.dart` exists

2. **"Vertex AI not available"**:
   - Enable Vertex AI in Google Cloud Console
   - Ensure billing is enabled
   - Check regional availability

3. **Build failures**:
   ```bash
   flutter clean
   flutter pub get
   # Try building again
   ```

## 📚 Documentation

- [README.md](README.md) - Complete setup and overview
- [FIREBASE_SETUP.md](FIREBASE_SETUP.md) - Detailed Firebase configuration
- [CONTRIBUTING.md](CONTRIBUTING.md) - How to contribute
- [DEPLOYMENT.md](DEPLOYMENT.md) - Deployment instructions
- [SECURITY.md](SECURITY.md) - Security policy

## 🤝 Contributing

1. Fork the repository
2. Create feature branch: `git checkout -b feature/amazing-feature`
3. Make changes and test thoroughly
4. Commit: `git commit -m 'Add amazing feature'`
5. Push: `git push origin feature/amazing-feature`
6. Open Pull Request

## 🆘 Getting Help

- **Issues**: [GitHub Issues](https://github.com/your-username/aetheria/issues)
- **Discussions**: [GitHub Discussions](https://github.com/your-username/aetheria/discussions)
- **Documentation**: Check all `.md` files in the repo

## 💡 Development Tips

- **Firebase Costs**: Vertex AI charges per request. Use development Firebase project for testing.
- **Platform Testing**: Test on multiple platforms when possible
- **Code Style**: Run `dart format .` before committing
- **Performance**: Use `flutter analyze` to catch issues early

---

**Happy coding! 🙏 May your development journey be blessed.**
