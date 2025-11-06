# AlgoTracer - Color Palette Guide

## 🎨 Official Color Palette

### Primary Background
```
Color: #000000 (Pure Black)
RGB: (0, 0, 0)
Usage: Screen backgrounds, main app background
```

### Card Background
```
Color: #222222 (Dark Gray)
RGB: (34, 34, 34)
Usage: Cards, panels, elevated surfaces, input fields
```

### Primary Accent
```
Color: #1DCD9F (Teal)
RGB: (29, 205, 159)
Usage: Primary CTAs, highlights, progress bars, success states
```

### Secondary Accent
```
Color: #169976 (Dark Teal)
RGB: (22, 153, 118)
Usage: Secondary buttons, alternative highlights, secondary CTAs
```

## 📍 Color Usage by Component

### Screens

#### Login/Signup Screens
- **Background**: #000000 (Primary Background)
- **Input Fields**: #222222 (Card Background)
- **Input Focus Border**: #1DCD9F (Primary Accent)
- **Primary Button**: #1DCD9F background (Primary Accent)
- **Link Text**: #169976 (Secondary Accent)
- **Error Text**: Red (system)

#### Dashboard Screen
- **Background**: #000000 (Primary Background)
- **Stats Card**: #222222 (Card Background)
- **Level Text**: #1DCD9F (Primary Accent)
- **XP Text**: #1DCD9F (Primary Accent)
- **Progress Bar**: #1DCD9F (Primary Accent)
- **Category Headers**: #1DCD9F (Primary Accent)
- **Algorithm Cards**: #222222 (Card Background)
- **Completion Icon**: #1DCD9F (Primary Accent)
- **XP Reward Text**: #1DCD9F (Primary Accent)

#### Challenge Screens
- **Background**: #000000 (Primary Background)
- **Info Card**: #222222 (Card Background)
- **Score Text**: #169976 (Secondary Accent)
- **Target/Goal Text**: #1DCD9F (Primary Accent)
- **Active Elements**: #1DCD9F (Primary Accent)
- **Current Selection**: #169976 (Secondary Accent)
- **Inactive Elements**: #222222 (Card Background)
- **Primary Button**: #1DCD9F (Primary Accent)
- **Secondary Button**: #169976 (Secondary Accent)

#### Profile Screen
- **Background**: #000000 (Primary Background)
- **Stats Card**: #222222 (Card Background)
- **Level Value**: #1DCD9F (Primary Accent)
- **XP Value**: #169976 (Secondary Accent)
- **Streak Value**: #1DCD9F (Primary Accent)
- **Completed Value**: #169976 (Secondary Accent)
- **Badge Chips**: #1DCD9F with opacity (Primary Accent)
- **Logout Button Border**: #169976 (Secondary Accent)

#### Leaderboard Screen
- **Background**: #000000 (Primary Background)
- **Header Card**: #222222 (Card Background)
- **Rank Cards**: #222222 (Card Background)
- **Current User Card**: #1DCD9F with opacity (Primary Accent)
- **XP Text**: #169976 (Secondary Accent)
- **Username (Current)**: #1DCD9F (Primary Accent)

### Widgets

#### Stats Header
- **Container**: #222222 (Card Background)
- **Username**: White (default text)
- **Level Text**: #1DCD9F (Primary Accent)
- **Streak Value**: #1DCD9F (Primary Accent)
- **Completed Value**: #169976 (Secondary Accent)
- **XP Value**: #1DCD9F (Primary Accent)
- **Progress Bar**: #1DCD9F (Primary Accent)
- **Avatar Circle**: #1DCD9F with opacity (Primary Accent)

#### Algorithm Card
- **Card Background**: #222222 (Card Background)
- **Icon Container (Completed)**: #1DCD9F with opacity (Primary Accent)
- **Icon Container (In Progress)**: #169976 with opacity (Secondary Accent)
- **Title**: White (default text)
- **Description**: Gray (muted text)
- **XP Text**: #1DCD9F (Primary Accent)
- **Completion Icon**: #1DCD9F (Primary Accent)

#### Success Overlay
- **Dialog Background**: #222222 (Card Background)
- **Title**: #1DCD9F (Primary Accent)
- **Score Value**: #1DCD9F (Primary Accent)
- **XP Value**: #169976 (Secondary Accent)
- **Continue Button**: #1DCD9F (Primary Accent)
- **Confetti Colors**: #1DCD9F, #169976, White

### Interactive Elements

#### Buttons
- **Elevated (Primary)**: 
  - Background: #1DCD9F (Primary Accent)
  - Text: Black
- **Outlined (Secondary)**:
  - Border: #169976 (Secondary Accent)
  - Text: #169976 (Secondary Accent)
  - Background: Transparent

#### Input Fields
- **Background**: #222222 (Card Background)
- **Border (Normal)**: Transparent
- **Border (Focus)**: #1DCD9F (Primary Accent)
- **Border (Error)**: Red (system)
- **Text**: White (default)
- **Label**: Gray (muted)

#### Progress Indicators
- **Active**: #1DCD9F (Primary Accent)
- **Background**: Gray (muted)

### Challenge-Specific Colors

#### Binary Search
- **Array Elements (Active)**: #222222 (Card Background)
- **Array Elements (Inactive)**: Dark gray
- **Array Border (Active)**: #1DCD9F (Primary Accent)
- **Current Middle**: #169976 (Secondary Accent)
- **Found Target**: #1DCD9F (Primary Accent)

#### BST Insertion
- **Tree Nodes**: #1DCD9F (Primary Accent)
- **Current Node**: #169976 (Secondary Accent)
- **Node Text**: Black
- **Connecting Lines**: Gray
- **Go Left Button**: #169976 (Secondary Accent)
- **Go Right Button**: #1DCD9F (Primary Accent)

#### DP Table
- **Empty Cells**: #222222 (Card Background)
- **Filled Cells**: #1DCD9F with opacity (Primary Accent)
- **Table Border**: #1DCD9F (Primary Accent)
- **Cell Text (Filled)**: #1DCD9F (Primary Accent)

### Feedback Colors

#### Hints
- **Info Hint**: Blue background
- **Error Hint**: Red background
- **Success Hint**: Green background
- **Icon**: White
- **Text**: White

#### Difficulty Indicators
- **Easy (1)**: Green
- **Medium (2)**: Orange
- **Hard (3)**: Red
- **Inactive**: Gray

## 🎯 Color Accessibility

### Contrast Ratios
- **Primary Accent on Black**: 7.2:1 (AAA)
- **Secondary Accent on Black**: 5.8:1 (AA)
- **White on Card Background**: 15.8:1 (AAA)
- **Primary Accent on Card Background**: 6.5:1 (AAA)

### Usage Guidelines
1. **Always use theme references**: `Theme.of(context).colorScheme.primary`
2. **Never hardcode colors**: Avoid `Color(0xFF1DCD9F)` in widgets
3. **Maintain contrast**: Ensure text is readable on backgrounds
4. **Use opacity sparingly**: Only for subtle backgrounds
5. **Consistent application**: Same color for same purpose across app

## 🔧 Implementation

### Theme Definition
```dart
// lib/theme/app_theme.dart
class AppTheme {
  static const Color primaryBackground = Color(0xFF000000);
  static const Color cardBackground = Color(0xFF222222);
  static const Color primaryAccent = Color(0xFF1DCD9F);
  static const Color secondaryAccent = Color(0xFF169976);
}
```

### Theme Usage
```dart
// In widgets
Container(
  color: Theme.of(context).scaffoldBackgroundColor, // #000000
)

Card(
  color: Theme.of(context).colorScheme.surface, // #222222
)

Text(
  'Hello',
  style: TextStyle(
    color: Theme.of(context).colorScheme.primary, // #1DCD9F
  ),
)

ElevatedButton(
  // Automatically uses #1DCD9F from theme
)
```

## 📊 Color Distribution

### By Usage Frequency
1. **#000000 (Primary Background)**: ~40% - All screen backgrounds
2. **#222222 (Card Background)**: ~35% - Cards, inputs, surfaces
3. **#1DCD9F (Primary Accent)**: ~20% - Highlights, CTAs, progress
4. **#169976 (Secondary Accent)**: ~5% - Secondary actions, alternatives

### By Visual Impact
1. **#1DCD9F (Primary Accent)**: Highest - Draws attention
2. **#169976 (Secondary Accent)**: Medium - Supporting elements
3. **#222222 (Card Background)**: Low - Subtle elevation
4. **#000000 (Primary Background)**: Lowest - Recedes to background

## 🎨 Color Psychology

### #1DCD9F (Primary Accent - Teal)
- **Feeling**: Fresh, modern, energetic
- **Association**: Growth, learning, progress
- **Effect**: Motivating, encouraging
- **Perfect for**: CTAs, achievements, success

### #169976 (Secondary Accent - Dark Teal)
- **Feeling**: Stable, trustworthy, calm
- **Association**: Reliability, consistency
- **Effect**: Supporting, grounding
- **Perfect for**: Secondary actions, alternatives

### #222222 (Card Background - Dark Gray)
- **Feeling**: Professional, sleek, modern
- **Association**: Sophistication, focus
- **Effect**: Elevates content, reduces eye strain
- **Perfect for**: Content containers, surfaces

### #000000 (Primary Background - Black)
- **Feeling**: Bold, powerful, focused
- **Association**: Premium, immersive
- **Effect**: OLED-friendly, battery-saving, content-focused
- **Perfect for**: Main background, maximum contrast

## ✅ Color Checklist

When adding new features, ensure:
- [ ] All colors use theme references
- [ ] No hardcoded color values
- [ ] Proper contrast ratios maintained
- [ ] Consistent with existing color usage
- [ ] Primary accent for main actions
- [ ] Secondary accent for alternative actions
- [ ] Card background for elevated surfaces
- [ ] Primary background for screen backgrounds

## 🌟 Color Best Practices

1. **Hierarchy**: Use primary accent sparingly for maximum impact
2. **Consistency**: Same color for same purpose everywhere
3. **Contrast**: Always check text readability
4. **Opacity**: Use for subtle backgrounds, not primary elements
5. **Accessibility**: Maintain WCAG AA standards minimum
6. **Theme-based**: Always use Theme.of(context)
7. **Future-proof**: Easy to switch to light mode later

---

**Strict adherence to this color palette ensures a consistent, professional, and accessible user experience throughout AlgoTracer!** 🎨✨
