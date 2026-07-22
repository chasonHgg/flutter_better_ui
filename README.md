# Better UI

[中文文档](https://github.com/chasonHgg/flutter_better_ui/blob/main/README_ZH.md)

A modern Flutter UI component library that provides beautiful and easy-to-use widgets, with theme customization and responsive design. Actively maintained.

## ✨ Features

- 🎨 **Modern design** - Built on Material Design 3
- 🌙 **Theming** - Light/Dark theme switching
- 🌐 **Localization** - Runtime locale switching and parameterized translations
- 📱 **Responsive** - Adapts to different screen sizes
- ⚡ **High performance** - Optimized rendering
- 🛠️ **Extensible** - Modular and easy to customize

## 🎥 Preview

<div>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/1.gif" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/2.gif" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/3.gif" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/4.gif" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/5.gif" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/6.gif" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/7.gif" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/8.gif" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/9.gif" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/10.jpg" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/11.jpg" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/12.gif" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/13.png" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/14.png" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/15.png" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/16.png" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/17.gif" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/18.png" width="200"/>
</div>

## 📦 Components

### Basic Components

- **BetterButton** - Enhanced button with multiple styles and states
- **BetterTextButton** - Text button
- **BetterCell** - List cell item

### Feedback Components

- **BetterToast** - Lightweight toast with multiple positions and styles
- **BetterPopup** - Popup layer with multiple presentation styles
- **BetterDialog** - Alert and confirmation dialog with theme customization

### Form Components

- **BetterPicker** - Picker supporting single, multiple, and cascading selections
- **BetterSwitch** - Customizable switch with loading state and async control
- **BetterDatePicker** - Date picker with flexible column types and formatting options
- **BetterTimePicker** - Time picker with flexible column types and formatting options

### Action Components

- **BetterSwipeCell** - Swipeable cell with left and right action buttons
- **BetterSlideAction** - Slide-to-complete action button with reverse direction and reset controller

### Display Components

- **BetterSwiper** - Used to loop through a set of images or content
- **BetterImagePreview** - Full-screen image preview with paging, gesture zoom, and customizable states
- **BetterMarquee** - Used for looping and displaying a set of message notifications
- **BetterCollapse** - Collapse panel for showing and hiding grouped content
- **BetterSkeletonizer** - Skeleton loading wrapper that automatically renders placeholders from child layout
- **BetterProgress** - Vant-style animated progress bar with custom pivots and controller-based updates

### Utilities

- **BetterScreenUtil** - Screen adaptation utilities
- **ColorUtil** - Color utilities
- **BetterAssets** - Generates Dart asset constant classes from image folders

## 🚀 Quick Start

### Installation

Add the dependency in `pubspec.yaml`:

```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  flutter_better_ui: ^3.0.0
```

### Initialize

```dart
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(
    BetterUi(
      designWidth: 375,
      designHeight: 812,
      // Use builders when the theme contains .bw/.bsp responsive values.
      themeBuilder: () => betterLightTheme,
      darkThemeBuilder: () => betterDarkTheme,
      themeMode: ThemeMode.system,
      translations: const {
        'en_US': {'remaining_days': '@days days left'},
        'zh_CN': {'remaining_days': '剩余 @days 天'},
      },
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      builder: (context, config) => MaterialApp(
        navigatorKey: BetterUi.navigatorKey,
        theme: config.theme,
        darkTheme: config.darkTheme,
        themeMode: config.themeMode,
        locale: config.locale,
        supportedLocales: config.supportedLocales,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        home: const HomePage(),
      ),
    ),
  );
}
```

### Theme and locale switching

```dart
BetterUi.toggleTheme();
BetterUi.changeThemeMode(ThemeMode.dark);
BetterUi.changeTheme(customLightTheme);
BetterUi.changeDarkTheme(customDarkTheme);

BetterUi.updateLocale(const Locale('zh', 'CN'));

'remaining_days'.trParams({'days': 3}); // 剩余 3 天
```

Use a native `MaterialApp` or `MaterialApp.router` inside `BetterUi.builder`.

## 📖 Usage Guide

### BetterButton - Button

```dart
// Basic button
BetterButton(
  text: "Click me",
  textStyle: TextStyle(color: Colors.red),
  onTap: () {
    print("Button clicked");
  },
)

// Primary button
BetterButton(
  type: BetterButtonType.primary,
  text: "Primary Button",
  onTap: () {},
)

// Loading state button
BetterButton(
  text: "Loading",
  loading: true,
  onTap: () {},
)

// Plain button
BetterButton(
  type: BetterButtonType.primary,
  plain: true,
  text: "Plain Button",
  onTap: () {},
)

// Custom button
BetterButton(
  decoration: BoxDecoration(
    color: Colors.red,
  ),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.add, color: Colors.white),
      Text('Custom', style: TextStyle(color: Colors.white)),
    ],
  ),
)
```

### BetterToast - Toast

```dart
// Basic toast
BetterToast.show(
  message: "Operation succeeded",
);

// Custom style
BetterToast.show(
  message: "Custom toast",
  backgroundColor: Colors.blue,
  textColor: Colors.white,
  position: BetterToastPosition.center,
  duration: Duration(seconds: 3),
);

// Loading toast
BetterToast.showLoading();
BetterToast.hideLoading();
```

### BetterPopup - Popup

```dart
// Bottom popup
BetterPopup.show(
  position: BetterPopupPosition.bottom,
  child: Container(
    height: 300,
    child: Center(child: Text("Bottom popup content")),
  ),
);

// Center popup
BetterPopup.show(
  position: BetterPopupPosition.center,
  child: Container(
    width: 300,
    height: 200,
    child: Center(child: Text("Centered popup content")),
  ),
);
```

### BetterDialog - Dialog

```dart
// Alert dialog
BetterDialog.showDialog(
  title: "Alert Dialog",
  content: "This is an alert dialog",
);

// Alert dialog without title
BetterDialog.showDialog(
  content: "This is an alert dialog without title",
);

// Confirmation dialog
BetterDialog.showDialog(
  title: "Confirm",
  content: "Are you sure you want to continue?",
  showCancelButton: true,
  onConfirm: () {
    print("Confirmed");
  },
  onCancel: () {
    print("Cancelled");
  },
);

// Custom bottom content
BetterDialog.showDialog(
  title: "Custom Action",
  content: "Use a custom button area",
  buttomWidget: Padding(
    padding: EdgeInsets.only(bottom: 10, left: 16, right: 16),
    child: BetterButton(
      width: double.infinity,
      text: "Confirm",
      textStyle: TextStyle(color: Colors.white),
      decoration: BoxDecoration(color: Colors.red),
      onTap: () {
        Navigator.of(context).pop();
      },
    ),
  ),
);
```

### BetterPicker - Picker

```dart
// Single-column picker
BetterPicker.show(
  columns: [
    BetterPickerItem(text: 'Option 1', value: 'option1'),
    BetterPickerItem(text: 'Option 2', value: 'option2'),
    BetterPickerItem(text: 'Option 3', value: 'option3'),
  ],
  onConfirm: (items) {
    print("Selected: ${items.first.text}");
  },
);

// Multi-column picker
BetterPicker.show(
  columns: [
    [
      BetterPickerItem(text: 'Monday', value: 'Monday'),
      BetterPickerItem(text: 'Tuesday', value: 'Tuesday'),
      BetterPickerItem(text: 'Wednesday', value: 'Wednesday'),
    ],
    [
      BetterPickerItem(text: 'Morning', value: 'Morning'),
      BetterPickerItem(text: 'Afternoon', value: 'Afternoon'),
      BetterPickerItem(text: 'Evening', value: 'Evening'),
    ],
  ],
  onConfirm: (items) {
    print("Selected: ${items.map((item) => item.text).join(', ')}");
  },
);

// Cascading picker
BetterPicker.show(
  columns: [
    BetterPickerItem(
      text: 'Zhejiang',
      value: 'Zhejiang',
      children: [
        BetterPickerItem(
          text: 'Hangzhou',
          value: 'Hangzhou',
          children: [
            BetterPickerItem(text: 'Xihu District', value: 'Xihu'),
            BetterPickerItem(text: 'Yuhang District', value: 'Yuhang'),
          ],
        ),
        BetterPickerItem(
          text: 'Wenzhou',
          value: 'Wenzhou',
          children: [
            BetterPickerItem(text: 'Lucheng District', value: 'Lucheng'),
            BetterPickerItem(text: 'Ouhai District', value: 'Ouhai'),
          ],
        ),
      ],
    ),
  ],
  onConfirm: (items) {
    print("Selected: ${items.map((item) => item.text).join(' - ')}");
  },
);

```


### BetterCell - List Cell

```dart
BetterCell(
    height: 44.bw,
    titleText: 'Cell',
    isShowBorder: true,
    isShowArrowRight: true,
    onTap(){
        print("on click")
    }
),
```

### BetterSwitch - Switch

```dart
// Basic switch
BetterSwitch(
  defaultValue: false,
  onChanged: (value) {
    print("Switch value: $value");
  },
)

// Loading state switch
BetterSwitch(
  loading: true,
  onChanged: (value) {
    print("Switch value: $value");
  },
)

// Custom size and colors
BetterSwitch(
  width: 44.bw,
  height: 26.bw,
  defaultValue: true,
  activeBackgroundColor: Colors.red,
  inactiveBackgroundColor: Colors.grey,
  onChanged: (value) {
    print("Switch value: $value");
  },
)

// Custom ball widget
BetterSwitch(
  width: 50.bw,
  height: 30.bw,
  ballWidget: Container(
    width: 26.bw,
    height: 26.bw,
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
    ),
    child: Icon(
      Icons.check,
      color: Theme.of(context).primaryColor,
      size: 16.bw,
    ),
  ),
  onChanged: (value) {
    print("Switch value: $value");
  },
)

// Disabled switch
BetterSwitch(
  disabled: true,
  onChanged: (value) {
    print("Switch is disabled");
  },
)

// Async control switch
BetterSwitch(
  onUpdateChange: () async {
    // Show confirmation dialog
    final result = await showCupertinoDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Confirm'),
        content: Text('Do you want to toggle the switch?'),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Confirm'),
          ),
        ],
      ),
    );
    return result ?? false;
  },
)
```

### BetterProgress - Progress Bar

`BetterProgress` displays a value from 0 to 100 and automatically clamps out-of-range values. Controller updates are rendered with `ValueListenableBuilder`, so no `setState` is required.

```dart
// Basic usage
BetterProgress(percentage: 50),

// Custom color, stroke width, and pivot
BetterProgress(
  percentage: 75,
  strokeWidth: 8.bw,
  color: Colors.red,
  trackColor: const Color(0xffffe1e1),
  pivotText: 'Active',
  pivotColor: Colors.red,
  pivotTextStyle: TextStyle(fontSize: 10.bsp),
),

// Hide the progress pivot
BetterProgress(percentage: 25, showPivot: false),
```

Use `BetterProgressController` to set, increase, or decrease progress programmatically:

```dart
final progressController = BetterProgressController(initialValue: 50);

BetterProgress(controller: progressController);

progressController.increase();    // Increase by 10
progressController.increase(5);   // Increase by 5
progressController.decrease();    // Decrease by 10
progressController.decrease(20);  // Decrease by 20
progressController.setValue(75);  // Set to 75

// Dispose it with the owning StatefulWidget
progressController.dispose();
```

#### BetterProgress properties

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `percentage` | `double` | `0` | Progress used without a controller, from 0 to 100 |
| `controller` | `BetterProgressController?` | `null` | Controls progress programmatically |
| `strokeWidth` | `double?` | `4.bw` | Progress bar thickness |
| `color` | `Color?` | Theme primary color | Progress color |
| `trackColor` | `Color?` | Theme surface color | Track color |
| `showPivot` | `bool` | `true` | Whether to show the progress pivot |
| `pivotText` | `String?` | Percentage | Custom pivot text |
| `pivotColor` | `Color?` | Progress color | Pivot background color |
| `pivotTextColor` | `Color` | `Colors.white` | Pivot text color |
| `pivotTextStyle` | `TextStyle?` | `null` | Pivot text style |
| `borderRadius` | `BorderRadiusGeometry?` | Automatic | Progress bar border radius |
| `animated` | `bool` | `true` | Whether progress changes are animated |
| `animationDuration` | `Duration` | `300ms` | Animation duration |
| `animationCurve` | `Curve` | `Curves.easeOut` | Animation curve |

### BetterSwipeCell - Swipeable Cell

```dart
// Basic swipe cell with left and right actions
BetterSwipeCell(
  leftActions: [
    BetterSwipeCellAction(
      width: 60.bw,
      onTap: (value) async {
        return true;
      },
      child: Container(
        color: Colors.blue,
        height: 54.bw,
        alignment: Alignment.center,
        child: Text(
          'Favorite',
          style: TextStyle(color: Colors.white, fontSize: 14.bsp),
        ),
      ),
    ),
  ],
  rightActions: [
    BetterSwipeCellAction(
      width: 60.bw,
      onTap: (value) async {
        return true;
      },
      child: Container(
        color: Colors.red,
        height: 54.bw,
        alignment: Alignment.center,
        child: Text(
          'Delete',
          style: TextStyle(color: Colors.white, fontSize: 14.bsp),
        ),
      ),
    ),
    BetterSwipeCellAction(
      width: 60.bw,
      onTap: (value) async {
        return true;
      },
      child: Container(
        color: Colors.blue,
        alignment: Alignment.center,
        child: Text(
          'Favorite',
          style: TextStyle(color: Colors.white, fontSize: 14.bsp),
        ),
      ),
    ),
  ],
  // Enable width extension
  // isStretch: true,
  child: BetterCell(
    height: 54.bw,
    titleText: 'Swipeable Cell',
    valueText: 'Content',
  ),
)

// Async control
BetterSwipeCell(
  rightActions: [
    BetterSwipeCellAction(
      width: 60.bw,
      value: 'favorite',
      child: Container(
        color: Colors.blue,
        alignment: Alignment.center,
        child: Text(
          'Favorite',
          style: TextStyle(color: Colors.white, fontSize: 14.bsp),
        ),
      ),
      onTap: (value) async {
        final result = await showCupertinoDialog<bool>(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text('Confirm'),
            content: Text('Add this item to favorites?'),
            actions: [
              CupertinoDialogAction(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 14.bsp,
                    color: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.color,
                  ),
                ),
                onPressed: () => Navigator.pop(context, false),
              ),
              CupertinoDialogAction(
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    fontSize: 14.bsp,
                    color: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.color,
                  ),
                ),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          ),
        );
        return result ?? false;
      },
    ),
  ],
  child: BetterCell(height: 54.bw, titleText: 'Async control'),
);
```

### BetterSlideAction - Slide Action Button

```dart
// Basic slide action
BetterSlideAction(
  color: Theme.of(context).primaryColor,
  onCompleted: () {
    BetterToast.showSuccess(message: 'Completed');
  },
  knobChild: Icon(Icons.chevron_right),
  children: Text(
    'Slide right to complete',
    style: TextStyle(color: Colors.white),
  ),
)

// Reverse direction, slide from right to left
BetterSlideAction(
  reverse: true,
  color: Colors.orange,
  onCompleted: () {
    BetterToast.showSuccess(message: 'Completed');
  },
  knobChild: Icon(Icons.chevron_left),
  children: Text(
    'Slide left to complete',
    style: TextStyle(color: Colors.white),
  ),
)

// Custom style and auto reset
BetterSlideAction(
  resetAfterCompleted: true,
  height: 58.bw,
  knobSize: 46.bw,
  boxDecoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12.bw),
    gradient: LinearGradient(
      colors: [Color(0xFFFF8A00), Color(0xFFFF4D4F)],
    ),
  ),
  onCompleted: () {
    BetterToast.showSuccess(message: 'Completed');
  },
  knobChild: Icon(Icons.lock_open),
  children: Text(
    'Slide to unlock',
    style: TextStyle(color: Colors.white),
  ),
)

// Reset with controller
final controller = BetterSlideActionController();

BetterSlideAction(
  controller: controller,
  color: Colors.blue,
  onCompleted: () {
    BetterToast.showSuccess(message: 'Completed');
  },
  knobChild: Icon(Icons.check),
  children: Text(
    'Manual reset',
    style: TextStyle(color: Colors.white),
  ),
)

BetterButton(
  type: BetterButtonType.primary,
  text: 'Reset',
  onTap: controller.reset,
)
```


### BetterDatePicker - Date Picker

```dart
// Basic date picker
BetterDatePicker.show(
  title: "Select date",
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("Selected date: ${selectedValues.map((e) => e.value).join('-')}");
  },
);

// Date picker with custom range
BetterDatePicker.show(
  title: "Select date",
  minDate: [2022, 1, 1],
  maxDate: [2024, 12, 31],
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("Selected date: ${selectedValues.map((e) => e.value).join('-')}");
  },
);

// Date picker with custom formatting
BetterDatePicker.show(
  title: "Select date",
  formatter: (BetterDatePickerFormatterOption option) {
    if (option.columnType == BetterDatePickerColumnType.year) {
      return "${option.text} year";
    }
    if (option.columnType == BetterDatePickerColumnType.month) {
      return "${option.text} month";
    }
    if (option.columnType == BetterDatePickerColumnType.day) {
      return "${option.text} day";
    }
    return option.text;
  },
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("Selected date: ${selectedValues.map((e) => e.value).join('-')}");
  },
);

// Date picker with specific column types (year and month only)
BetterDatePicker.show(
  title: "Select year and month",
  columnTypes: [
    BetterDatePickerColumnType.year,
    BetterDatePickerColumnType.month,
  ],
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("Selected year-month: ${selectedValues.map((e) => e.value).join('-')}");
  },
);

// Date picker with default value
BetterDatePicker.show(
  title: "Select date",
  defaultValue: [2025, 9, 8],
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("Selected date: ${selectedValues.map((e) => e.value).join('-')}");
  },
);

// Date picker with filtering (e.g., only show months divisible by 6)
BetterDatePicker.show(
  title: "Select date",
  columnTypes: [
    BetterDatePickerColumnType.year,
    BetterDatePickerColumnType.month,
  ],
  filter: (BetterDatePickerFilterOption option) {
    if (option.columnType == BetterDatePickerColumnType.month) {
      return option.value % 6 == 0; // Only show months 6 and 12
    }
    return true;
  },
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("Selected date: ${selectedValues.map((e) => e.value).join('-')}");
  },
);

// Date picker without default today
BetterDatePicker.show(
  title: "Select date",
  isDefaultShowToday: false,
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("Selected date: ${selectedValues.map((e) => e.value).join('-')}");
  },
);
```

### BetterTimePicker - Time Picker

```dart
// Basic time picker
BetterTimePicker.show(
  title: "Select time",
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("Selected time: ${selectedValues.map((e) => e.value).join(':')}");
  },
);

// Time picker with custom range
BetterTimePicker.show(
  title: "Select time",
  minDate: [10, 0, 0],
  maxDate: [18, 59, 59],
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("Selected time: ${selectedValues.map((e) => e.value).join(':')}");
  },
);

// Time picker with custom formatting
BetterTimePicker.show(
  title: "Select time",
  formatter: (BetterTimePickerFormatterOption option) {
    if (option.columnType == BetterTimePickerColumnType.hour) {
      return "${option.text} hour";
    }
    if (option.columnType == BetterTimePickerColumnType.minute) {
      return "${option.text} minute";
    }
    if (option.columnType == BetterTimePickerColumnType.second) {
      return "${option.text} second";
    }
    return option.text;
  },
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("Selected time: ${selectedValues.map((e) => e.value).join(':')}");
  },
);

// Time picker with specific column types (hour and minute only)
BetterTimePicker.show(
  title: "Select hour and minute",
  columnTypes: [
    BetterTimePickerColumnType.hour,
    BetterTimePickerColumnType.minute,
  ],
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("Selected hour-minute: ${selectedValues.map((e) => e.value).join(':')}");
  },
);

// Time picker with default value
BetterTimePicker.show(
  title: "Select time",
  defaultValue: [14, 30, 0],
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("Selected time: ${selectedValues.map((e) => e.value).join(':')}");
  },
);

// Time picker with filtering (e.g., only show minutes divisible by 5)
BetterTimePicker.show(
  title: "Select time",
  columnTypes: [
    BetterTimePickerColumnType.hour,
    BetterTimePickerColumnType.minute,
  ],
  filter: (BetterTimePickerFilterOption option) {
    if (option.columnType == BetterTimePickerColumnType.minute) {
      return option.value % 5 == 0; // Only show minutes 0, 5, 10, 15, etc.
    }
    return true;
  },
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("Selected time: ${selectedValues.map((e) => e.value).join(':')}");
  },
);

// Time picker without default current time
BetterTimePicker.show(
  title: "Select time",
  isDefaultShowNow: false,
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("Selected time: ${selectedValues.map((e) => e.value).join(':')}");
  },
);
```

### BetterSwiper

```dart
PageController pageController = PageController();
BetterSwiper(
  controller: pageController,
  height: 200.bw,
  autoplay: true,
  loop: true,
  scrollDirection: Axis.horizontal,
  children: [
    Container(width: double.infinity, color: Colors.red),
    Container(width: double.infinity, color: Colors.blue),
    Container(width: double.infinity, color: Colors.green),
  ],
),
```

### BetterImagePreview - Image Preview

`BetterImagePreview` builds pages on demand with `PageView.builder` and precaches the images adjacent to the current page. Values beginning with `http://` or `https://` are loaded as network images; other values are treated as Flutter asset paths.

```dart
// Basic usage; images is required.
await BetterImagePreview.show(
  context: context, // Optional; defaults to BetterUi.currentContext.
  images: const [
    'assets/images/cat.jpeg',
    'https://example.com/image-1.jpg',
    'https://example.com/image-2.jpg',
  ],
  startPosition: 0,
  onChange: (index) {
    print('Current image: $index');
  },
  onClose: (index) {
    print('Closed at image: $index');
  },
);
```

Vertical paging and zoom controls:

```dart
BetterImagePreview.show(
  images: images,
  vertical: true,     // Swipe vertically; defaults to false.
  doubleScale: false, // Disable double-tap zoom; pinch zoom remains enabled.
  closeOnTap: false,
  closeable: true,
);
```

After zooming, pan the image to an edge and keep dragging to switch to the previous or next page. Edge handoff works in both horizontal and vertical modes.

Custom page index:

```dart
BetterImagePreview.show(
  images: images,
  indexBuilder: (context, index, total) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.bw, vertical: 5.bw),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(14.bw),
      ),
      child: Text(
        '${index + 1} / $total',
        style: TextStyle(color: Colors.white, fontSize: 14.bsp),
      ),
    );
  },
);
```

Custom image appearance, loading, and error states:

The component shows a white loading indicator and a failure icon by default. Passing the corresponding builder replaces that default state. `imageBuilder` wraps the built-in image, so keep its `child` in the returned widget tree.

```dart
BetterImagePreview.show(
  images: images,
  imageBuilder: (context, image, index, child) {
    // Keep child in the tree to display the image and its loading/error states.
    return Padding(
      padding: EdgeInsets.all(20.bw),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.bw),
        child: child,
      ),
    );
  },
  loadingBuilder: (context, image, index) {
    return Center(
      child: CircularProgressIndicator(strokeWidth: 2.bw),
    );
  },
  errorBuilder: (context, image, index) {
    return Center(
      child: Icon(Icons.broken_image_outlined, size: 40.bw),
    );
  },
);
```

Main parameters:

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `context` | `BuildContext?` | `BetterUi.currentContext` | Route context |
| `images` | `List<String>` | Required | Non-empty network image URLs or asset paths |
| `startPosition` | `int` | `0` | Initial image index, clamped to the valid range |
| `loop` | `bool` | `true` | Enables circular paging |
| `vertical` | `bool` | `false` | Uses vertical instead of horizontal paging |
| `doubleScale` | `bool` | `true` | Enables double-tap zoom and reset |
| `minScale` / `maxScale` | `double` | `1` / `4` | Minimum and maximum zoom scales |
| `showIndex` | `bool` | `true` | Shows the page index |
| `closeable` | `bool` | `false` | Shows the close button |
| `closeOnTap` | `bool` | `true` | Closes when the image is tapped |
| `closePosition` | `BetterImagePreviewClosePosition` | `topRight` | Close button position |
| `backgroundColor` | `Color` | `Colors.black` | Preview background color |
| `transitionDuration` | `Duration` | `250ms` | Fade-in and fade-out duration |
| `onChange` / `onClose` | `ValueChanged<int>?` | `null` | Image change and preview close callbacks with the image index |
| `indexBuilder` | `Widget Function(...)` | `null` | Custom page index; the default is used when omitted |
| `imageBuilder` | `Widget Function(...)` | `null` | Wraps the built-in image widget |
| `loadingBuilder` / `errorBuilder` | `Widget Function(...)` | `null` | Custom loading and failure states |

The close button semantics use Flutter's `MaterialLocalizations`, so no specific localization package is required.

### BetterCollapse - Collapse Panel

```dart
// Basic collapse
BetterCollapse(
  children: BetterCollapseItem(
    title: Text('Title'),
    children: [
      Text('Content 1'),
      Text('Content 2'),
    ],
  ),
)

// Multiple panels
Column(
  children: [
    BetterCollapse(
      children: BetterCollapseItem(
        title: Text('Title 1'),
        children: [Text('Content 1')],
      ),
    ),
    BetterCollapse(
      children: BetterCollapseItem(
        title: Text('Title 2'),
        children: [Text('Content 2')],
      ),
    ),
  ],
)

// Control expand and collapse from outside
class CollapseDemo extends StatefulWidget {
  const CollapseDemo({super.key});

  @override
  State<CollapseDemo> createState() => _CollapseDemoState();
}

class _CollapseDemoState extends State<CollapseDemo> {
  late final ExpansibleController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ExpansibleController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ElevatedButton(
              onPressed: _controller.expand,
              child: Text('Expand'),
            ),
            ElevatedButton(
              onPressed: _controller.collapse,
              child: Text('Collapse'),
            ),
          ],
        ),
        BetterCollapse(
          expansibleController: _controller,
          children: BetterCollapseItem(
            title: Text('Title'),
            children: [Text('Content')],
          ),
        ),
      ],
    );
  }
}

// Custom title area, colors, ripple, and icon colors
BetterCollapse(
  minTitleHeight: 0,
  titleMinVerticalPadding: 0,
  titlePadding: EdgeInsets.symmetric(horizontal: 16.bw, vertical: 12.bw),
  background: Colors.white,
  collapsedBackground: Colors.white,
  iconColor: Colors.blue,
  collapsedIconColor: Colors.grey,
  splashColor: Colors.blue.withAlpha(20),
  contentPadding: EdgeInsets.symmetric(horizontal: 16.bw, vertical: 12.bw),
  showDivider: true,
  children: BetterCollapseItem(
    title: Text('Custom title'),
    children: [Text('Custom content')],
  ),
)
```

#### BetterCollapse Theme

```dart
ThemeData(
  extensions: [
    BetterThemeExtension(
      // ...other theme fields
      collapseTheme: BetterCollapseTheme(
        backgroundColor: Colors.white,
        collapsedBackground: Colors.white,
        iconColor: Colors.blue,
        collapsedIconColor: Colors.grey,
        splashColor: Colors.blue.withAlpha(20),
      ),
    ),
  ],
)
```

| Property | Description |
| --- | --- |
| `expansibleController` | Controls the panel from outside, such as expand and collapse |
| `titlePadding` | Padding of the title area |
| `minTitleHeight` | Minimum height of the title area |
| `titleMinVerticalPadding` | Removes or customizes the internal vertical padding of the title ListTile |
| `background` | Background color when expanded |
| `collapsedBackground` | Background color when collapsed |
| `iconColor` | Arrow icon color when expanded |
| `collapsedIconColor` | Arrow icon color when collapsed |
| `splashColor` | Ripple color when tapping the title area |
| `contentPadding` | Padding of the expanded content |


### BetterSkeletonizer - Skeleton Loading

`BetterSkeletonizer` keeps the original child layout and replaces painting with skeleton placeholders while `enabled` is true. It works with normal widgets and scrollable lists, and preserves Flutter's native lazy loading behavior.

```dart
BetterSkeletonizer(
  enabled: loading,
  child: ListView.builder(
    itemCount: 20,
    itemBuilder: (context, index) {
      return ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/avatar.png'),
        ),
        title: Text('Title $index'),
        subtitle: Text('Skeleton keeps the original layout.'),
      );
    },
  ),
)
```

When the request finishes, set `enabled` to `false` and the original child rendering is restored:

```dart
setState(() {
  loading = false;
});
```

#### Custom color and animation

```dart
BetterSkeletonizer(
  enabled: loading,
  lightBaseColor: Color(0xFFD9DDE3),
  darkBaseColor: Color(0xFF4B5563),
  fadeDuration: Duration(milliseconds: 900),
  minOpacity: 0.65,
  maxOpacity: 1,
  child: content,
)
```

#### BetterSkeletonizer properties

| Property | Description |
| --- | --- |
| `enabled` | Whether to show skeleton placeholders |
| `child` | Original content. It still participates in layout and scrolling |
| `baseColor` | Overrides the skeleton color for all theme modes |
| `lightBaseColor` | Skeleton color in light mode when `baseColor` is null |
| `darkBaseColor` | Skeleton color in dark mode when `baseColor` is null |
| `fadeDuration` | Duration of the pulsing opacity animation |
| `minOpacity` | Minimum opacity of the pulsing animation |
| `maxOpacity` | Maximum opacity of the pulsing animation |
| `textBorderRadius` | Border radius used for text placeholder lines |
| `defaultBorderRadius` | Default border radius used for general placeholders |
| `ignorePointers` | Whether to ignore child gestures while skeletons are enabled. Defaults to `false` so lists can keep scrolling |

### BetterMarquee

```dart
BetterMarquee(
  height: 40.bw,
  leftWidget: Icon(
    BetterIcon.volumeO,
    size: 16.bsp,
    color: ColorUtil.hexToColor("#ed6a0c"),
  ),
  textList: ["hello world"],
),
```

### BetterIndexBar

```dart
List<String> azList = [
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z',
];
BetterIndexBar(
  indexBarColor: ColorUtil.hexToColor("#323233"),
  indexBarActiveColor: ColorUtil.hexToColor("#1989fa"),
  headerSlivers: [
    SliverToBoxAdapter(
      child: Container(
        height: 100.bw,
        alignment: Alignment.center,
        color: ColorUtil.hexToColor("#fff"),
        child: Text("Custom content"),
      ),
    ),
  ],
  items: [
    for (var item in azList)
      BetterIndexBarItem(
        header: BetterIndexBarHeader(
          anchor: item,
          height: 32.bw,
          titleWidget: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16.bw),
            decoration: BoxDecoration(
              color:ColorUtil.hexToColor("#F7F8FA"),
            ),
            child: Text(
              item,
            ),
          ),
        ),
        list: [
          for (var i in List.generate(10, (index) => index))
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.bw),
              child: Container(
                height: 44.bw,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: i==9 ? BorderSide.none : BorderSide(
                      color:ColorUtil.hexToColor("#E5E5E5"),
                      width: 1.bw,
                    ),
                  ),
                ),
                child: Text("$item-text"),
              ),
            ),
        ],
      ),
  ],
)
```

## 🔧 Utilities

### BetterScreenUtil - Screen Adaptation

```dart
// Get screen information
double screenWidth = BetterScreenUtil.screenWidth;
double screenHeight = BetterScreenUtil.screenHeight;
double statusBarHeight = BetterScreenUtil.statusBarHeight;

// Responsive sizes
double responsiveWidth = 100.bw;
double responsiveHeight = 50.bh;
double responsiveFont = 16.bsp;
```

### ColorUtil - Color Utilities

```dart
// Color conversion
Color hexColor = ColorUtil.hexToColor("#FF0000");
```


### BetterAssets - Asset Constants Generator

`BetterAssets` scans a directory and generates a Dart class with static asset path constants.

```dart
import 'package:flutter_better_ui/utils/better_assets.dart';

void main() async {
  test('RefreshImages', () async {
    await BetterAssets.generate(
      projectPath: '.', // Optional. Defaults to the nearest parent directory with pubspec.yaml.
      imagePath: 'assets/images',
      codePath: 'lib/app_res',
      codeName: 'app_image',
      className: 'AppImages',
    );
  }
}
```

## ❓ FAQ

- **Why is the click area of a button inside a `ListView` too large?**

  Wrap the button with layout widgets such as `Align`, or configure its width, height, and padding explicitly.

## 📋 Example Project

See the `example/` directory for full usage examples:

- `better_button_page.dart` - Button examples
- `better_toast_page.dart` - Toast examples
- `better_popup_page.dart` - Popup examples
- `better_dialog_page.dart` - Dialog examples
- `better_picker_page.dart` - Picker examples
- `better_switch_page.dart` - Switch examples
- `better_cell_page.dart` - List cell examples
- `better_swipe_action_page.dart` - Swipe cell examples
- `better_slide_action_page.dart` - Slide action examples
- `better_date_picker_page.dart` - Date picker examples
- `better_time_picker_page.dart` - Time picker examples
- `better_swiper_page.dart` - Swiper examples
- `better_image_preview_page.dart` - Image preview examples
- `better_marquee_page.dart` - Marquee examples
- `better_collapse_page.dart` - Collapse examples
- `better_skeleton_page.dart` - Skeleton loading examples
- `better_progress_page.dart` - Progress bar examples

## 🤝 Contributing

Issues and Pull Requests are welcome!

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

## 🔗 Links

- [Flutter](https://flutter.dev)
- [Dart](https://dart.dev)
- [Material Design](https://material.io/design)
