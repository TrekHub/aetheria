# Contributing to Aetheria

Thank you for your interest in contributing to Aetheria! This document provides guidelines and information for contributors.

## 🎯 Ways to Contribute

- **Bug Reports**: Help us identify and fix issues
- **Feature Requests**: Suggest new features or improvements
- **Code Contributions**: Submit bug fixes, features, or improvements
- **Documentation**: Improve documentation and guides
- **Testing**: Test the app on different platforms and devices
- **UI/UX**: Suggest or implement design improvements

## 🚀 Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/your-username/aetheria.git
   cd aetheria
   ```
3. **Set up the development environment** following the main README
4. **Create a new branch** for your contribution:
   ```bash
   git checkout -b feature/your-feature-name
   ```

## 📝 Development Guidelines

### Code Style

- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused
- Use proper error handling

### Flutter Best Practices

- Use `const` constructors when possible
- Implement proper widget lifecycle management
- Use appropriate state management (Provider in this project)
- Follow Material Design guidelines
- Ensure responsive design across different screen sizes

### Firebase Integration

- Always check Firebase initialization before using services
- Handle Firebase exceptions properly
- Use appropriate Firebase security rules
- Test Firebase integration thoroughly
- Document Firebase configuration changes

### Testing

- Write unit tests for business logic
- Test UI components when possible
- Test on multiple platforms (Android, iOS, Web)
- Verify Firebase integration works correctly
- Test offline scenarios where applicable

## 🔧 Code Formatting

Before submitting code, ensure it follows the project standards:

```bash
# Format all Dart files
dart format .

# Analyze code for issues
flutter analyze

# Run tests
flutter test
```

## 🐛 Bug Reports

When reporting bugs, please include:

- **Device/Platform information** (Android version, iOS version, etc.)
- **Flutter version** (`flutter --version`)
- **Steps to reproduce** the issue
- **Expected behavior** vs **actual behavior**
- **Screenshots or videos** if applicable
- **Error messages** or stack traces
- **Firebase project configuration** (without sensitive data)

Use this template for bug reports:

```markdown
## Bug Description

Brief description of the bug

## Steps to Reproduce

1. Go to...
2. Click on...
3. See error

## Expected Behavior

What should happen

## Actual Behavior

What actually happens

## Environment

- Platform: [Android/iOS/Web/macOS/Windows]
- Device: [Device model if mobile]
- OS Version: [Version number]
- Flutter Version: [Run `flutter --version`]
- App Version: [Version from pubspec.yaml]

## Screenshots

[If applicable]

## Additional Context

[Any other relevant information]
```

## ✨ Feature Requests

For feature requests, please include:

- **Clear description** of the feature
- **Use case** or problem it solves
- **Proposed implementation** (if you have ideas)
- **UI mockups** (if applicable)
- **Priority level** (nice-to-have vs essential)

## 📋 Pull Request Process

1. **Ensure your code follows** the style guidelines
2. **Update documentation** if you change functionality
3. **Add or update tests** for your changes
4. **Test on multiple platforms** when possible
5. **Update CHANGELOG.md** with your changes
6. **Create a descriptive PR title** and description

### PR Title Format

- `feat: add new sermon filtering feature`
- `fix: resolve Firebase initialization issue`
- `docs: update setup instructions`
- `refactor: improve sermon service structure`
- `test: add unit tests for daily verse provider`

### PR Description Template

```markdown
## Description

Brief description of changes

## Type of Change

- [ ] Bug fix (non-breaking change that fixes an issue)
- [ ] New feature (non-breaking change that adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update

## Testing

- [ ] Tested on Android
- [ ] Tested on iOS
- [ ] Tested on Web
- [ ] Added/updated unit tests
- [ ] Firebase integration tested

## Screenshots

[If applicable]

## Checklist

- [ ] My code follows the style guidelines
- [ ] I have performed a self-review
- [ ] I have commented complex code
- [ ] I have updated documentation
- [ ] My changes generate no new warnings
- [ ] I have tested my changes
```

## 🏗️ Project Structure

When contributing, understand the project structure:

```
lib/
├── main.dart                    # App entry point
├── firebase_options.dart        # Firebase configuration
├── providers/                   # State management
│   ├── daily_verse_provider.dart
│   └── sermon_provider.dart
├── screens/                     # UI screens
│   ├── dashboard_screen.dart
│   ├── sermon_display_screen.dart
│   ├── sermon_form_screen.dart
│   └── splash_screen.dart
├── service/                     # Business logic & API calls
│   ├── daily_verse_service.dart
│   └── sermon_service.dart
└── models/                      # Data models (add as needed)
```

## 🚦 Development Workflow

### Branch Naming

Use descriptive branch names:

- `feature/sermon-categories`
- `fix/firebase-auth-crash`
- `docs/setup-guide-improvements`
- `refactor/provider-optimization`

### Commit Messages

Follow conventional commit format:

- `feat: add sermon search functionality`
- `fix: resolve daily verse loading issue`
- `docs: update Firebase setup guide`
- `style: format code according to dart style`
- `refactor: optimize sermon provider performance`
- `test: add unit tests for verse service`

## 🔥 Firebase Development

### Testing Firebase Changes

- Use a separate Firebase project for development
- Test all Firebase services (AI, Auth, etc.)
- Ensure proper error handling for Firebase exceptions
- Test offline behavior where applicable

### Security Considerations

- Never commit Firebase API keys or sensitive configuration
- Use Firebase Security Rules appropriately
- Test authentication flows thoroughly
- Validate user input before sending to Firebase services

## 🎨 UI/UX Guidelines

### Design Principles

- **Simple and Clean**: Keep the interface uncluttered
- **Accessible**: Ensure good contrast and text sizes
- **Consistent**: Use consistent colors, fonts, and spacing
- **Responsive**: Work well on different screen sizes
- **Intuitive**: Easy to navigate and understand

### Colors and Theming

- Follow Material Design color guidelines
- Maintain consistency with the existing color scheme
- Consider accessibility (color contrast)
- Test in both light and dark modes if applicable

## 📦 Dependencies

### Adding New Dependencies

Before adding new dependencies:

1. **Check if it's really needed** - can you implement it yourself?
2. **Verify the package quality** - check pub.dev ratings and maintenance
3. **Check compatibility** with existing dependencies
4. **Consider bundle size** impact
5. **Update documentation** if the dependency requires setup

### Dependency Guidelines

- Prefer well-maintained packages
- Avoid packages with known security issues
- Use specific version constraints
- Document any required setup in README

## 🧪 Testing Guidelines

### Unit Tests

Write unit tests for:

- Service layer logic (sermon generation, verse fetching)
- Provider state management
- Utility functions
- Data parsing and validation

### Widget Tests

Test UI components for:

- Proper rendering
- User interaction handling
- State changes
- Error states

### Integration Tests

Test complete user flows:

- Sermon generation process
- Daily verse display
- Navigation between screens
- Firebase service integration

## 📚 Documentation

### Code Documentation

- Document complex functions with clear comments
- Use dartdoc comments for public APIs
- Include usage examples for complex features
- Keep comments up-to-date with code changes

### README Updates

When adding features:

- Update the features list
- Add new setup steps if required
- Update screenshots if UI changes
- Add troubleshooting info for common issues

## 🎖️ Recognition

Contributors will be recognized in:

- GitHub contributors list
- CHANGELOG.md for significant contributions
- Special mentions for major features or fixes

## 📞 Getting Help

If you need help:

1. **Check existing issues** and documentation
2. **Ask questions** in GitHub issues
3. **Join discussions** in pull request comments
4. **Be patient and respectful** when asking for help

## 📄 Code of Conduct

Please be respectful and professional in all interactions:

- Be welcoming to newcomers
- Respect different viewpoints and experiences
- Focus on constructive feedback
- Help create a positive community environment

---

Thank you for contributing to Aetheria! Together we can build something amazing that inspires and supports spiritual growth. 🙏
