# App Icon Setup

## Quick Setup

1. **Create your icon image** (1024x1024 PNG) and save as `assets/icon.png`

2. **Install dependencies:**
```bash
flutter pub get
```

3. **Generate icons:**
```bash
flutter pub run flutter_launcher_icons
```

## Icon Requirements

- **Size**: 1024x1024 pixels minimum
- **Format**: PNG with transparency
- **Design**: Simple, recognizable at small sizes
- **Colors**: Use app theme colors (#1DCD9F on dark background)

## Suggested Icon Design

Create a simple icon with:
- Dark background (#000000 or #222222)
- Teal accent (#1DCD9F)
- Algorithm symbol (e.g., binary tree, graph, or "A" letter)

## Tools to Create Icon

- **Figma** (free online)
- **Canva** (free templates)
- **Adobe Illustrator**
- **GIMP** (free)

## After Generation

Icons will be automatically placed in:
- `android/app/src/main/res/mipmap-*/ic_launcher.png`
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

## Test

Run the app to see your new icon:
```bash
flutter run
```
