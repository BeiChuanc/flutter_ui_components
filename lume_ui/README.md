# Lume UI

A collection of beautiful and reusable Flutter UI components for building modern mobile applications.

## Features

- 🔘 **Button Components** - Apple Login, Back Button, Report Button with blur effects
- 💬 **Dialog Components** - Behavior dialogs, Global tooltips, Report dialogs, Update user dialogs
- 🎬 **Media Components** - Media player, Media showcase with thumbnail generation, Carousel with multiple indicator effects
- 🌐 **WebView** - Protocol pages for Terms, Privacy Policy, EULA
- ✨ **Effects** - Gaussian blur, Danmaku (barrage) pool, Rotation animations
- 📱 **Layout** - Global screen component, Status bar component, Slide bottom navigation, Tack scroll
- 🎨 **Utilities** - HexColor extension, Overlap avatars, No data placeholder, Protocol text

## Getting Started

### Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  lume_ui: ^1.0.3
```

Then run:

```bash
flutter pub get
```

### Setup

1. Initialize `ScreenUtil` in your app:

```dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        home: child,
      ),
      child: const HomePage(),
    );
  }
}
```

## Usage

### Import

```dart
import 'package:lume_ui/lume_ui.dart';
```

### Button Components

```dart
// Apple Login Button
AppleLogin(
  image: 'assets/icons/apple_logo.png',
  appleLoginCallback: () {
    // Handle login
  },
)

// Back Button with blur effect
GlobalBackButton(
  config: BackButtonConfig(
    size: 25.0,
    hasBlur: true,
    image: 'assets/icons/back.png',
  ),
)

// Report Button
ReportButton(
  size: 24,
  image: 'assets/icons/report.png',
  isNeedBlur: true,
  onTap: () {},
)
```

### Dialog Components

```dart
// Global Tooltip
GlobalTooltip.show('Message');
GlobalTooltip.success('Success!');
GlobalTooltip.error('Error!');
GlobalTooltip.warning('Warning!');
GlobalTooltip.info('Info');

// Behavior Dialog
BehaviorDialogBox.delete(
  context,
  content: 'Are you sure you want to delete?',
  onConfirm: () {},
);

// Update User Dialog
UpdateUserDialog.updateName(
  context,
  currentName: 'John',
  onConfirm: (newName) {},
);
```

### Media Components

```dart
// Media Showcase (auto-detects image/video)
MediaShowCase(
  mediaUrl: 'assets/images/photo.jpg',
  width: 200.w,
  height: 150.h,
  borderRadius: 12,
)

// Carousel
Carousel(
  images: ['image1.jpg', 'image2.jpg', 'image3.jpg'],
  width: double.infinity,
  height: 200.h,
  effectType: IndicatorEffectType.expanding,
  onTap: (index) {},
)

// Full-screen Media Player
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => MediaPlayer(mediaUrl: 'video.mp4'),
  ),
);
```

### Gaussian Blur Effect

```dart
GaussianBlur(
  radius: 16,
  paddingH: 20,
  paddingV: 12,
  hasBorder: true,
  blurSigma: 15,
  child: Text('Blurred Background'),
)
```

### Danmaku (Barrage) Pool

```dart
final controller = DanmakuPoolController();

DanmakuPool<String>(
  controller: controller,
  dataSource: ['Hello', 'World', 'Flutter'],
  textExtractor: (data) => data,
  onBarrageTap: (data) {},
  config: DanmakuPoolConfig(
    trackCount: 5,
    emitInterval: 1500,
  ),
)

// Control methods
controller.start();
controller.stop();
controller.publish('New message');
```

### HexColor Extension

```dart
Color color1 = HexColor.fromHex('#FF5722');
Color color2 = HexColor.fromHex('2196F3');
Color color3 = HexColor.fromHex('#000000', opacity: 0.5);
```

## Components Overview

| Category | Components |
|----------|------------|
| Button | `AppleLogin`, `GlobalBackButton`, `ReportButton` |
| Dialog | `BehaviorDialogBox`, `GlobalTooltip`, `ReportDialog`, `UpdateUserDialog` |
| Media | `MediaPlayer`, `MediaShowCase`, `Carousel` |
| WebView | `WebViewComponent`, `ProtocolType` |
| Effects | `GaussianBlur`, `DanmakuPool`, `RotationButton` |
| Layout | `GlobalScreenComponent`, `GlobalStatusComponent`, `SlideBottom`, `TackScroll` |
| Other | `OverlapAvatar`, `NoDataPlaceholder`, `ProtocolText`, `HexColor` |

## Additional Information

- **Repository**: [GitHub](https://github.com/BeiChuanc/flutter_ui_components)
- **Issues**: Please file issues on the [GitHub issue tracker](https://github.com/BeiChuanc/flutter_ui_components/issues)
- **License**: MIT

## Author

Created by 周灿 (1486129104@qq.com)
