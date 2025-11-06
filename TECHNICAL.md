# AlgoTracer - Technical Documentation

## Architecture Overview

### Design Pattern: Provider + MVVM

```
View (Screens/Widgets)
    ↓
ViewModel (Providers)
    ↓
Model (Models + Services)
```

### State Management

**Provider Pattern** is used throughout the app:
- `UserProvider`: Manages authentication state and user data
- Centralized state updates with `notifyListeners()`
- Efficient rebuilds with `Consumer` and `context.watch()`

### Data Persistence

**SharedPreferences** for local storage:
- User authentication data
- Progress tracking
- Scores and achievements
- No backend required for MVP

## Theme System

### Centralized Theme Configuration

All colors are defined in `lib/theme/app_theme.dart`:

```dart
class AppTheme {
  static const Color primaryBackground = Color(0xFF000000);
  static const Color cardBackground = Color(0xFF222222);
  static const Color primaryAccent = Color(0xFF1DCD9F);
  static const Color secondaryAccent = Color(0xFF169976);
}
```

### Theme Usage

**Always use theme references:**
```dart
// ✅ Correct
color: Theme.of(context).colorScheme.primary

// ❌ Wrong
color: Color(0xFF1DCD9F)
```

### Benefits
- Single source of truth
- Easy theme switching
- Consistent UI across app
- Future-proof for light mode

## Key Components

### 1. Authentication Flow

```
LoginScreen → AuthService.login() → UserProvider.loadUser() → DashboardScreen
```

**Security Considerations:**
- Passwords stored in SharedPreferences (demo only)
- Production: Use Firebase Auth or similar
- Email validation on client side
- Password minimum length enforcement

### 2. Challenge System

Each challenge implements:
- State management for game logic
- Visual feedback for user actions
- Score calculation
- Hint system
- Success overlay with confetti

**Challenge Interface:**
```dart
class Challenge extends StatefulWidget {
  final AlgorithmModel algorithm;
  
  // Implements:
  // - Interactive UI
  // - Validation logic
  // - Score tracking
  // - Completion callback
}
```

### 3. Progress Tracking

```dart
class AlgorithmProgress {
  final bool completed;
  final int attempts;
  final int bestScore;
  final DateTime? lastAttempt;
}
```

Stored per algorithm in user's progress map.

## Animation System

### flutter_animate Package

Used for micro-interactions:
```dart
Widget.animate()
  .fadeIn(duration: 300.ms)
  .slideX(begin: 0.2, end: 0)
```

### confetti Package

Celebration effects on challenge completion:
```dart
ConfettiWidget(
  confettiController: _confettiController,
  blastDirectionality: BlastDirectionality.explosive,
)
```

## Screen Breakdown

### LoginScreen
- Form validation
- Error handling
- Navigation to signup
- Auto-login on success

### DashboardScreen
- Stats header with user info
- Categorized algorithm list
- Progress indicators
- Navigation to challenges/profile/leaderboard

### ChallengeScreen
- Router for different challenge types
- Passes algorithm model to specific challenge
- Handles back navigation

### ProfileScreen
- User statistics display
- Badge showcase
- Logout functionality

### LeaderboardScreen
- Mock global ranking
- Highlights current user
- Medal system for top 3

## Challenge Implementation Details

### Binary Search Challenge

**State Variables:**
```dart
List<int> _array;      // Sorted array
int _target;           // Number to find
int _left, _right;     // Search boundaries
int? _mid;             // Current middle index
int _score;            // Current score
String? _hint;         // Feedback message
```

**Logic:**
1. User taps an index
2. Validate if it's the correct middle
3. If correct and matches target → Success
4. If correct but not target → Update boundaries
5. If incorrect → Show hint, reduce score

### BST Insertion Challenge

**State Variables:**
```dart
TreeNode? _root;           // Tree root
List<int> _toInsert;       // Values to insert
int _currentIndex;         // Current value index
TreeNode? _currentNode;    // Current position in tree
```

**Logic:**
1. Present value to insert
2. User chooses left or right
3. Validate based on BST property
4. Navigate to child or insert new node
5. Repeat until all values inserted

**Custom Painter:**
- Calculates node positions recursively
- Draws connecting lines
- Renders nodes with values
- Highlights current node

### DP Table Challenge

**State Variables:**
```dart
List<List<int?>> _table;   // DP table (null = empty)
List<List<int>> _solution; // Correct answers
List<TextEditingController> _controllers; // Input fields
```

**Logic:**
1. Pre-fill base cases
2. User enters value in empty cell
3. Validate against solution
4. Update table if correct
5. Check if table complete

## Adding New Algorithms

### Step 1: Add to AlgorithmModel

```dart
AlgorithmModel(
  id: 'new_algorithm',
  name: 'Algorithm Name',
  description: 'Brief description',
  category: AlgorithmCategory.arrays,
  difficulty: 2,
  xpReward: 150,
  icon: '🎯',
)
```

### Step 2: Create Challenge Widget

```dart
class NewAlgorithmChallenge extends StatefulWidget {
  final AlgorithmModel algorithm;
  
  @override
  State<NewAlgorithmChallenge> createState() => _NewAlgorithmChallengeState();
}

class _NewAlgorithmChallengeState extends State<NewAlgorithmChallenge> {
  // Implement challenge logic
  // Use theme colors
  // Add confetti on success
  // Call context.read<UserProvider>().completeAlgorithm()
}
```

### Step 3: Add to ChallengeScreen Router

```dart
case 'new_algorithm':
  challenge = NewAlgorithmChallenge(algorithm: algorithm);
  break;
```

## Performance Considerations

### Optimizations
- `const` constructors where possible
- Efficient list rendering with `ListView.builder`
- Minimal rebuilds with targeted `Consumer` widgets
- Lazy loading of challenge screens

### Memory Management
- Dispose controllers in `dispose()`
- Cancel timers and animations
- Clear confetti controllers

## Testing Strategy

### Unit Tests
- Model serialization/deserialization
- Algorithm validation logic
- Score calculation

### Widget Tests
- Screen navigation
- Form validation
- Button interactions

### Integration Tests
- Complete user flows
- Challenge completion
- Progress persistence

## Deployment Checklist

### Android
1. Update `android/app/build.gradle` with version
2. Generate signing key
3. Build release APK: `flutter build apk --release`
4. Test on physical device
5. Upload to Play Store

### iOS
1. Update version in Xcode
2. Configure signing certificates
3. Build release: `flutter build ios --release`
4. Archive and upload to App Store Connect
5. Submit for review

## Security Best Practices

### Current Implementation (Demo)
- ⚠️ Passwords in SharedPreferences (not secure)
- ⚠️ No encryption
- ⚠️ No backend validation

### Production Recommendations
- ✅ Use Firebase Authentication
- ✅ Implement proper password hashing
- ✅ Add backend API for data sync
- ✅ Encrypt sensitive local data
- ✅ Add rate limiting
- ✅ Implement proper session management

## Scalability Considerations

### Current Limitations
- Local storage only
- No cloud sync
- Limited to device storage

### Future Enhancements
- Backend API integration
- Cloud Firestore for real-time sync
- User-generated content
- Social features
- Analytics integration

## Code Style Guidelines

### Naming Conventions
- Classes: `PascalCase`
- Variables: `camelCase`
- Private members: `_leadingUnderscore`
- Constants: `camelCase` with `static const`

### File Organization
- One widget per file (for major widgets)
- Group related widgets in same file (for small helpers)
- Imports: Flutter → Dart → Package → Relative

### Widget Structure
```dart
class MyWidget extends StatelessWidget {
  // 1. Constructor
  const MyWidget({super.key, required this.data});
  
  // 2. Fields
  final String data;
  
  // 3. Build method
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // ...
  }
  
  // 4. Helper methods (if needed)
  void _helperMethod() {}
}
```

## Debugging Tips

### Common Issues

**Theme not applying:**
- Check `Theme.of(context)` is used
- Verify widget is inside `MaterialApp`

**State not updating:**
- Ensure `notifyListeners()` is called
- Check `Consumer` or `context.watch()` is used

**Navigation issues:**
- Use `Navigator.of(context)` not `Navigator`
- Check route is properly defined

### Debug Tools
```bash
# Hot reload
r

# Hot restart
R

# Performance overlay
flutter run --profile

# Debug paint
flutter run --debug
```

## Performance Monitoring

### Key Metrics
- Frame rendering time (target: 60fps)
- Memory usage
- App startup time
- Challenge load time

### Tools
- Flutter DevTools
- Performance overlay
- Memory profiler

---

## Contributing Guidelines

1. Follow existing code structure
2. Use theme colors (never hardcode)
3. Add comments for complex logic
4. Test on both Android and iOS
5. Ensure animations are smooth
6. Validate all user inputs
7. Handle errors gracefully

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Provider Package](https://pub.dev/packages/provider)
- [Material Design](https://material.io/design)
- [Flutter Animate](https://pub.dev/packages/flutter_animate)
