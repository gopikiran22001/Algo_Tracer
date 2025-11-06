# AlgoTracer - Quick Start Guide

## \ud83d\ude80 Getting Started in 3 Steps

### 1. Run the App
```bash
flutter run
```

### 2. Create an Account
- Tap "Don't have an account? Sign up"
- Enter username (min 3 characters)
- Enter email (valid format)
- Enter password (min 6 characters)
- Tap "Sign Up"

### 3. Start Learning!
You'll see the dashboard with algorithm categories.

## \ud83c\udfae How to Play

### Dashboard Overview
- **Stats Header**: Shows your level, streak, completed algorithms, and XP
- **Progress Bar**: Visual indicator of XP progress to next level
- **Algorithm Cards**: Organized by category with difficulty indicators

### Starting a Challenge

1. **Tap any algorithm card** to begin
2. **Read the instructions** at the top
3. **Follow visual cues** for interactive elements
4. **Make choices** by tapping/entering values
5. **Get instant feedback** with hints for mistakes
6. **Complete successfully** to earn XP and level up!

## \ud83c\udfaf Interactive Challenges Explained

### Binary Search Challenge
- **Goal**: Find the target number in a sorted array
- **How**: Tap the middle element of the active search range
- **Tip**: The active range is highlighted with the primary accent color
- **Scoring**: Lose 10 points for each wrong selection

### BST Insertion Challenge
- **Goal**: Insert numbers into a Binary Search Tree correctly
- **How**: Choose "Go Left" or "Go Right" based on value comparison
- **Tip**: If new value < current node, go left; otherwise go right
- **Scoring**: Lose 15 points for each wrong direction

### DP Table Challenge
- **Goal**: Fill a dynamic programming table using the recurrence relation
- **How**: Tap empty cells, enter the correct value, press Enter
- **Formula**: dp[i][j] = max(dp[i-1][j], dp[i][j-1]) + 1
- **Scoring**: Lose 10 points for each incorrect value

## \ud83c\udfc6 Gamification System

### XP & Levels
- Earn XP by completing challenges
- Each algorithm has different XP rewards based on difficulty
- Level up every 500 XP
- Higher levels unlock more challenging algorithms

### Scoring
- Start each challenge with 100 points
- Points decrease with mistakes
- Final score affects your leaderboard ranking

### Streaks
- Complete challenges daily to maintain your streak
- Streaks are displayed on your profile and dashboard

### Badges
- Unlock badges for achievements (coming soon)
- Display badges on your profile

## \ud83d\udcca Profile & Progress

### View Your Stats
1. Tap the **person icon** in the top-right
2. See your:
   - Level and total XP
   - Current streak
   - Completed algorithms count
   - Earned badges

### Leaderboard
1. Tap the **leaderboard icon** in the top-right
2. See global rankings
3. Your position is highlighted
4. Top 3 get special medals

## \ud83c\udfa8 Color Scheme Reference

The app uses a consistent dark theme:

- **Background**: Pure black (#000000) for OLED optimization
- **Cards**: Dark gray (#222222) for content separation
- **Primary Actions**: Teal (#1DCD9F) for CTAs and highlights
- **Secondary Actions**: Dark teal (#169976) for secondary buttons
- **Success**: Green tones for correct answers
- **Error**: Red tones for mistakes
- **Hints**: Orange/Blue tones for guidance

## \ud83d\udd27 Troubleshooting

### App won't start?
```bash
flutter clean
flutter pub get
flutter run
```

### Login issues?
- Ensure email contains "@"
- Password must be at least 6 characters
- Username must be at least 3 characters

### Challenge not responding?
- Make sure you're tapping the correct interactive elements
- Check if you've already completed the step
- Look for visual highlights indicating active areas

## \ud83d\udcdd Tips for Success

1. **Read instructions carefully** before starting each challenge
2. **Pay attention to hints** - they guide you to the correct solution
3. **Take your time** - accuracy matters more than speed
4. **Review the algorithm explanation** provided in each challenge
5. **Practice daily** to maintain your streak and level up faster

## \ud83d\udce6 Next Steps

After mastering the three sample algorithms:
- More challenges will be added
- Try to achieve 100 score on each challenge
- Compete on the leaderboard
- Unlock all badges
- Reach the highest level

## \ud83d\udcac Support

For issues or questions:
- Check the in-app instructions
- Review algorithm explanations in each challenge
- Hints appear automatically when you make mistakes

---

**Happy Learning! \ud83c\udf89**

Master algorithms through play, one challenge at a time.
