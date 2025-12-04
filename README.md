# 🚀 Flutter CI/CD Demo App

![Flutter CI](https://github.com/YOUR_USERNAME/YOUR_REPO/workflows/Flutter%20CI/badge.svg)
![Coverage](https://img.shields.io/badge/coverage-70%25+-green)
![Flutter Version](https://img.shields.io/badge/flutter-3.24.0-blue)
![License](https://img.shields.io/badge/license-MIT-blue)

A production-ready Flutter application demonstrating comprehensive CI/CD implementation with GitHub Actions, automated testing, code quality gates, and multi-environment configuration.

## ✨ Features

- 🔄 **Full CI/CD Pipeline** - Automated testing, analysis, and builds
- 📊 **Code Quality Gates** - Strict linting rules and 70%+ test coverage
- 🌍 **Multi-Environment Support** - Dev, Staging, and Production configurations
- 🏗️ **Flutter Flavors** - Separate builds for each environment
- 🧪 **Comprehensive Testing** - Unit and widget tests with high coverage
- 🏷️ **Automated Versioning** - Automatic build number incrementation
- 📦 **Artifact Management** - APK builds uploaded for each environment

## 🏗️ Architecture

### Environment Configuration

The app supports three environments:

- **Development** (`dev`) - For active development and testing
- **Staging** (`staging`) - Pre-production testing environment
- **Production** (`prod`) - Live production environment

Each environment has its own:

- API endpoints
- App name and branding
- Debug features toggle
- Application ID (for Android)

### Project Structure

```
l13/
├── .github/
│   └── workflows/
│       └── ci.yml                 # Main CI/CD pipeline
├── lib/
│   ├── config/
│   │   └── app_config.dart        # Environment configuration
│   ├── main.dart                  # Default entry point
│   ├── main_dev.dart              # Development entry point
│   ├── main_staging.dart          # Staging entry point
│   └── main_prod.dart             # Production entry point
├── test/
│   ├── config/
│   │   └── app_config_test.dart   # Config unit tests
│   └── widget_test.dart           # Widget tests
├── scripts/
│   ├── check_coverage.sh          # Coverage threshold checker
│   └── increment_version.sh       # Version bump automation
└── android/
    └── app/
        └── build.gradle.kts       # Flavor configuration
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.24.0 or higher
- Dart SDK 3.5.0 or higher
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**

```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
cd l13
```

2. **Install dependencies**

```bash
flutter pub get
```

3. **Run the app**

#### Using Dart Define (Simple Approach)

```bash
# Development
flutter run --dart-define=BUILD_ENV=dev --dart-define=API_URL=https://api-dev.example.com

# Staging
flutter run --dart-define=BUILD_ENV=staging --dart-define=API_URL=https://api-staging.example.com

# Production
flutter run --dart-define=BUILD_ENV=prod --dart-define=API_URL=https://api.example.com
```

#### Using Flutter Flavors

```bash
# Development
flutter run --flavor dev --target lib/main_dev.dart

# Staging
flutter run --flavor staging --target lib/main_staging.dart

# Production
flutter run --flavor prod --target lib/main_prod.dart
```

## 🧪 Testing

### Run All Tests

```bash
flutter test
```

### Run Tests with Coverage

```bash
flutter test --coverage
```

### Check Coverage Threshold

```bash
# On Linux/macOS (requires lcov)
bash scripts/check_coverage.sh
```

### Coverage Requirements

- Minimum coverage: **70%**
- Coverage is automatically checked in CI pipeline

## 📊 Code Quality

### Format Code

```bash
dart format .
```

### Analyze Code

```bash
flutter analyze
```

### Run All Quality Checks

```bash
dart format --output=none --set-exit-if-changed .
flutter analyze --fatal-infos
flutter test --coverage
bash scripts/check_coverage.sh
```

## 🏗️ Building

### Build APK for Specific Environment

#### Without Flavors

```bash
# Development
flutter build apk --dart-define=BUILD_ENV=dev --dart-define=API_URL=https://api-dev.example.com

# Staging
flutter build apk --dart-define=BUILD_ENV=staging --dart-define=API_URL=https://api-staging.example.com

# Production
flutter build apk --dart-define=BUILD_ENV=prod --dart-define=API_URL=https://api.example.com
```

#### With Flavors

```bash
# Development
flutter build apk --flavor dev --target lib/main_dev.dart

# Staging
flutter build apk --flavor staging --target lib/main_staging.dart

# Production
flutter build apk --flavor prod --target lib/main_prod.dart
```

## 🔄 CI/CD Pipeline

### Pipeline Stages

1. **Analyze** - Code formatting and static analysis
2. **Test** - Run all tests with coverage check
3. **Build** - Build APKs for all environments
4. **Version Bump** - Automatic version increment (main branch only)

### Workflow Triggers

- **Push** to `main` or `develop` branches
- **Pull Requests** to `main` or `develop` branches

### Build Artifacts

After successful pipeline execution, APK files are available as artifacts:

- `app-dev-release.apk`
- `app-staging-release.apk`
- `app-prod-release.apk`

Artifacts are retained for 30 days.

## 📝 Version Management

### Manual Version Bump

```bash
bash scripts/increment_version.sh
```

### Automatic Version Bump

- Automatically triggered on pushes to `main` branch
- Increments build number in `pubspec.yaml`
- Commits changes with `[skip ci]` tag

## 🔧 Configuration

### Environment Variables

Available via `--dart-define`:

- `BUILD_ENV` - Environment name (dev, staging, prod)
- `API_URL` - API base URL
- `APP_NAME` - Custom app name
- `API_VERSION` - API version (default: v1)
- `API_TIMEOUT` - API timeout in seconds (default: 30)
- `PRODUCTION` - Boolean flag for production mode

### App Configuration

Configuration is centralized in `lib/config/app_config.dart`:

```dart
// Access configuration
AppConfig.environment        // Current environment
AppConfig.apiBaseUrl        // API URL
AppConfig.appName           // App name
AppConfig.isProduction      // Is production?
AppConfig.enableDebugFeatures  // Debug features enabled?
```

## 📖 Analysis Options

Strict linting rules are enforced via `analysis_options.yaml`:

- ✅ Strict type checking
- ✅ Comprehensive lint rules (100+ rules)
- ✅ No warnings allowed in CI
- ✅ Consistent code style

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run tests and ensure coverage (`flutter test --coverage`)
5. Commit changes (`git commit -m 'Add amazing feature'`)
6. Push to branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

### Commit Message Convention

We follow conventional commits:

- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `style:` - Code style changes
- `refactor:` - Code refactoring
- `test:` - Test changes
- `chore:` - Build/tooling changes

## 📋 Requirements

- ✅ Flutter SDK 3.24.0+
- ✅ Dart SDK 3.5.0+
- ✅ 70%+ test coverage
- ✅ No analyzer warnings
- ✅ Properly formatted code
- ✅ All tests passing

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- GitHub Actions for CI/CD infrastructure
- Open source community for inspiration

## 📞 Contact

- **Author**: Your Name
- **Email**: <your.email@example.com>
- **GitHub**: [@yourusername](https://github.com/yourusername)

## 📚 Additional Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Flutter Flavors Guide](https://docs.flutter.dev/deployment/flavors)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)

---

**Made with ❤️ and Flutter**
