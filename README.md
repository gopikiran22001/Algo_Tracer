# AlgoTracer - Gamified Algorithm Learning App

A production-ready Flutter mobile application that helps users learn and master algorithms through interactive, step-by-step challenges with real-time feedback.

## Features

### 🎯 Core Features
- **Authentication System**: Secure login/signup with error handling
- **Algorithm Dashboard**: Categorized algorithms (Arrays, Strings, Hashing, Data Structures, DP, Graphs)
- **Interactive Challenges**: Visual, step-by-step algorithm solving
- **Gamification**: Points, streaks, badges, and level system
- **Progress Tracking**: Completion states, stats, and achievements
- **Leaderboard**: Global ranking system
- **User Profile**: Stats, badges, and customization

### 🎮 Interactive Algorithms
1. **Binary Search**: Visual array search with elimination
2. **BST Insertion**: Interactive binary search tree building
3. **DP Table Fill**: Step-by-step dynamic programming

### 🎨 Design System
- **Primary Background**: #000000
- **Card/Surface**: #222222
- **Primary Accent**: #1DCD9F
- **Secondary Accent**: #169976
- Theme-based architecture for easy customization

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── theme/
│   └── app_theme.dart       # Centralized theme configuration
├── models/
│   ├── user_model.dart      # User data model
│   └── algorithm_model.dart # Algorithm data model
├── providers/
│   └── user_provider.dart   # State management
├── services/
│   └── auth_service.dart    # Authentication logic
├── screens/
│   ├── login_screen.dart
│   ├── signup_screen.dart
│   ├── dashboard_screen.dart
│   ├── challenge_screen.dart
│   ├── profile_screen.dart
│   └── leaderboard_screen.dart
├── widgets/
│   ├── stats_header.dart
│   ├── algorithm_card.dart
│   └── success_overlay.dart
└── challenges/
    ├── binary_search_challenge.dart
    ├── bst_insertion_challenge.dart
    └── dp_table_challenge.dart
```

## Setup Instructions

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / Xcode for mobile deployment

### Installation

1. **Clone the repository**
   ```bash
   cd algo_tracer
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Build for Production

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

## Usage

1. **Sign Up**: Create an account with email and username
2. **Explore Dashboard**: Browse algorithms by category
3. **Start Challenge**: Tap any algorithm to begin interactive learning
4. **Complete Steps**: Follow visual cues and make correct choices
5. **Earn Rewards**: Gain XP, level up, and unlock badges
6. **Track Progress**: View stats in your profile
7. **Compete**: Check leaderboard rankings

## Key Technologies

- **Flutter**: Cross-platform mobile framework
- **Provider**: State management
- **SharedPreferences**: Local data persistence
- **flutter_animate**: Smooth animations
- **confetti**: Celebration effects

## Architecture Highlights

- **Theme-based Design**: All colors use Theme.of(context) for consistency
- **Provider Pattern**: Centralized state management
- **Modular Structure**: Separated concerns (models, services, screens, widgets)
- **Responsive Design**: Safe areas and proper padding for all devices
- **Extensible**: Easy to add new algorithms and features

## Future Enhancements

- More algorithm challenges (Sorting, Graph traversals, etc.)
- Social features (Friends, challenges)
- Daily challenges and quests
- Dark/Light theme toggle
- Offline mode improvements
- Analytics and insights

## License

This project is a demonstration of production-ready Flutter development practices.
