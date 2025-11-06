# AlgoTracer - Deployment Guide

## 🚀 Quick Start

### Run the App Immediately
```bash
cd algo_tracer
flutter run
```

The app will launch on your connected device or emulator.

## 📱 Platform-Specific Deployment

### Android Deployment

#### 1. Build APK (Debug)
```bash
flutter build apk --debug
```
Output: `build/app/outputs/flutter-apk/app-debug.apk`

#### 2. Build APK (Release)
```bash
flutter build apk --release
```
Output: `build/app/outputs/flutter-apk/app-release.apk`

#### 3. Build App Bundle (For Play Store)
```bash
flutter build appbundle --release
```
Output: `build/app/outputs/bundle/release/app-release.aab`

#### 4. Install on Device
```bash
flutter install
```

#### 5. Generate Signing Key (For Production)
```bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

Then update `android/app/build.gradle`:
```gradle
signingConfigs {
    release {
        keyAlias 'upload'
        keyPassword 'your-password'
        storeFile file('path/to/upload-keystore.jks')
        storePassword 'your-password'
    }
}
```

### iOS Deployment

#### 1. Open Xcode Project
```bash
open ios/Runner.xcworkspace
```

#### 2. Configure Signing
- Select Runner in project navigator
- Go to Signing & Capabilities
- Select your Team
- Xcode will automatically manage provisioning

#### 3. Build for Device
```bash
flutter build ios --release
```

#### 4. Archive and Upload
- In Xcode: Product → Archive
- Once archived: Distribute App → App Store Connect
- Follow prompts to upload

## 🔧 Pre-Deployment Checklist

### Code Quality
- [x] No hardcoded colors (all use theme)
- [x] Proper error handling
- [x] Input validation
- [x] Memory management (dispose methods)
- [x] No console warnings (only deprecation info)

### Testing
- [ ] Test on multiple screen sizes
- [ ] Test on Android device
- [ ] Test on iOS device
- [ ] Test all user flows
- [ ] Test offline behavior
- [ ] Test edge cases

### Assets & Configuration
- [ ] Update app name in `pubspec.yaml`
- [ ] Update version number
- [ ] Add app icon (use flutter_launcher_icons)
- [ ] Add splash screen
- [ ] Update Android package name
- [ ] Update iOS bundle identifier

### Performance
- [ ] Profile app performance
- [ ] Check memory usage
- [ ] Optimize images (if any added)
- [ ] Test on low-end devices

### Security
- [ ] Remove debug prints
- [ ] Secure sensitive data
- [ ] Add ProGuard rules (Android)
- [ ] Enable code obfuscation

## 📦 App Store Submission

### Google Play Store

#### 1. Create Developer Account
- Go to [Google Play Console](https://play.google.com/console)
- Pay $25 one-time fee
- Complete account setup

#### 2. Create App
- Click "Create app"
- Fill in app details:
  - Name: AlgoTracer
  - Default language: English
  - App or game: App
  - Free or paid: Free

#### 3. Prepare Store Listing
- **Short description** (80 chars):
  "Learn algorithms through interactive, gamified challenges"

- **Full description** (4000 chars):
  ```
  Master algorithms through play! AlgoTracer is a gamified learning app that makes algorithm education fun and engaging.

  🎮 INTERACTIVE CHALLENGES
  • Binary Search: Visual array searching
  • BST Insertion: Build binary search trees
  • DP Table: Fill dynamic programming tables
  • Real-time feedback and hints

  🏆 GAMIFICATION
  • Earn XP and level up
  • Maintain daily streaks
  • Unlock badges and achievements
  • Compete on global leaderboard

  📊 TRACK PROGRESS
  • Monitor completion status
  • View detailed statistics
  • Track best scores
  • See improvement over time

  🎨 BEAUTIFUL DESIGN
  • Modern dark theme
  • Smooth animations
  • Intuitive interface
  • Optimized for mobile

  Perfect for:
  • Computer science students
  • Interview preparation
  • Algorithm enthusiasts
  • Anyone learning to code

  Start your algorithm mastery journey today!
  ```

- **Screenshots**: 
  - Minimum 2, maximum 8
  - Recommended: 1080x1920 or 1440x2560
  - Capture: Login, Dashboard, Challenge, Profile

- **Feature graphic**: 1024x500
- **App icon**: 512x512

#### 4. Content Rating
- Complete questionnaire
- AlgoTracer should be rated "Everyone"

#### 5. Pricing & Distribution
- Free app
- Select countries
- No ads (currently)

#### 6. Upload App Bundle
- Upload the `.aab` file
- Fill in release notes
- Submit for review

### Apple App Store

#### 1. Create Developer Account
- Go to [Apple Developer](https://developer.apple.com)
- Pay $99/year
- Complete enrollment

#### 2. Create App in App Store Connect
- Go to [App Store Connect](https://appstoreconnect.apple.com)
- Click "My Apps" → "+"
- Fill in app information:
  - Name: AlgoTracer
  - Primary language: English
  - Bundle ID: (from Xcode)
  - SKU: unique identifier

#### 3. Prepare App Information
- **Subtitle** (30 chars):
  "Master Algorithms Through Play"

- **Description** (4000 chars):
  Same as Google Play

- **Keywords** (100 chars):
  "algorithm,learning,education,coding,programming,computer science,interview,practice"

- **Screenshots**:
  - iPhone 6.7": 1290x2796
  - iPhone 6.5": 1242x2688
  - iPad Pro 12.9": 2048x2732

- **App Preview** (optional):
  - 15-30 second video

#### 4. Build Upload
- Archive in Xcode
- Upload to App Store Connect
- Wait for processing

#### 5. Submit for Review
- Select build
- Fill in review information
- Add demo account (if needed)
- Submit

## 🔐 Security Configuration

### Android ProGuard
Create `android/app/proguard-rules.pro`:
```proguard
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
```

Update `android/app/build.gradle`:
```gradle
buildTypes {
    release {
        signingConfig signingConfigs.release
        minifyEnabled true
        shrinkResources true
        proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
    }
}
```

### iOS Code Obfuscation
```bash
flutter build ios --release --obfuscate --split-debug-info=build/ios/symbols
```

## 📊 Analytics Setup (Optional)

### Firebase Analytics
1. Add Firebase to project
2. Update `pubspec.yaml`:
```yaml
dependencies:
  firebase_core: ^2.24.0
  firebase_analytics: ^10.7.0
```

3. Initialize in `main.dart`:
```dart
await Firebase.initializeApp();
```

### Track Events
```dart
FirebaseAnalytics.instance.logEvent(
  name: 'challenge_completed',
  parameters: {'algorithm': 'binary_search'},
);
```

## 🔄 Continuous Integration (Optional)

### GitHub Actions
Create `.github/workflows/flutter.yml`:
```yaml
name: Flutter CI

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.8.1'
      - run: flutter pub get
      - run: flutter analyze
      - run: flutter test
      - run: flutter build apk --release
```

## 📈 Post-Launch

### Monitor
- App crashes (Firebase Crashlytics)
- User reviews
- Download numbers
- User engagement

### Update Strategy
1. Fix critical bugs immediately
2. Add new algorithms monthly
3. Improve based on feedback
4. Regular performance optimization

### Version Numbering
- Format: MAJOR.MINOR.PATCH+BUILD
- Example: 1.0.0+1
- Increment for each release

## 🐛 Troubleshooting

### Build Errors

**Gradle build failed:**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter build apk
```

**iOS build failed:**
```bash
cd ios
pod deintegrate
pod install
cd ..
flutter clean
flutter pub get
flutter build ios
```

**Dependencies conflict:**
```bash
flutter pub upgrade --major-versions
```

### Runtime Issues

**App crashes on startup:**
- Check SharedPreferences initialization
- Verify all assets are included
- Check for null safety issues

**Theme not applying:**
- Ensure MaterialApp uses AppTheme.darkTheme
- Verify all widgets use Theme.of(context)

**Animations laggy:**
- Profile with Flutter DevTools
- Check for unnecessary rebuilds
- Optimize heavy computations

## 📞 Support

### Resources
- [Flutter Documentation](https://docs.flutter.dev/)
- [Play Store Help](https://support.google.com/googleplay/android-developer)
- [App Store Help](https://developer.apple.com/support/app-store/)

### Common Questions

**Q: How to update the app?**
A: Increment version in `pubspec.yaml`, build, and upload new version.

**Q: How to add new algorithms?**
A: See TECHNICAL.md "Adding New Algorithms" section.

**Q: How to change theme colors?**
A: Update `lib/theme/app_theme.dart` only.

**Q: How to add backend?**
A: Integrate Firebase or create REST API, update services layer.

## ✅ Final Checklist

Before submitting to stores:
- [ ] App builds successfully
- [ ] All features tested
- [ ] No console errors
- [ ] Screenshots prepared
- [ ] Store listing written
- [ ] Privacy policy created (if needed)
- [ ] Terms of service created (if needed)
- [ ] App icon finalized
- [ ] Version number updated
- [ ] Release notes written

## 🎉 Launch!

Once approved:
1. Announce on social media
2. Share with friends and family
3. Gather feedback
4. Plan next updates
5. Monitor analytics
6. Respond to reviews

---

**Your production-ready AlgoTracer app is ready for the world!** 🚀📱
