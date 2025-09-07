# Better UI

[中文文档](https://github.com/chasonHgg/flutter_better_ui/blob/main/README_ZH.md)

A modern Flutter UI component library that provides beautiful and easy-to-use widgets, with theme customization and responsive design. Actively maintained.

## ✨ Features

- 🎨 **Modern design** - Built with Material Design 3
- 🌙 **Theming** - Light/Dark theme switching
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
</div>


## 📦 Components

### Basic Components
- **BetterButton** - Enhanced button with multiple styles and states
- **BetterTextButton** - Text button
- **BetterCell** - List cell item

### Feedback Components
- **BetterToast** - Lightweight toast with multiple positions and styles
- **BetterPopup** - Popup layer with multiple presentation styles

### Form Components
- **BetterPicker** - Picker supporting single, multiple, and cascading selections
- **BetterSwitch** - Customizable switch with loading state and async control

### Feedback component
- **BetterSwipeCell** - Swipeable cell with left and right action buttons



### Utilities
- **BetterScreenUtil** - Screen adaptation utilities
- **ColorUtil** - Color utilities

## 🚀 Quick Start

### Installation

Add the dependency in `pubspec.yaml`:

```yaml
dependencies:
  better_ui: ^lastversion
```

### Initialize

```dart
void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    //init Better UI,mast be first line
     BetterUtil.init(context, designWidth: 375, designHeight: 812);
    return MaterialApp(
       body: HomePage();
    );
  }
}

```

## 📖 Usage Guide

### BetterButton - Button

```dart
// Basic button
BetterButton(
  text: "Click me",
  onClick: () {
    print("Button clicked");
  },
)

// Primary button
BetterButton(
  type: BetterButtonType.primary,
  text: "Primary Button",
  onClick: () {},
)

// Loading state button
BetterButton(
  text: "Loading",
  loading: true,
  onClick: () {},
)

// Plain button
BetterButton(
  type: BetterButtonType.primary,
  plain: true,
  text: "Plain Button",
  onClick: () {},
)
```

### BetterToast - Toast

```dart
// Basic toast
BetterToast.show(
  context,
  message: "Operation succeeded",
);

// Custom style
BetterToast.show(
  context,
  message: "Custom toast",
  backgroundColor: Colors.blue,
  textColor: Colors.white,
  position: BetterToastPosition.center,
  duration: Duration(seconds: 3),
);

// Loading toast
BetterToast.showLoading(context);
BetterToast.hideLoading();
```

### BetterPopup - Popup

```dart
// Bottom popup
BetterPopup.show(
  context,
  position: BetterPopupPosition.bottom,
  child: Container(
    height: 300,
    child: Center(child: Text("Bottom popup content")),
  ),
);

// Center popup
BetterPopup.show(
  context,
  position: BetterPopupPosition.center,
  child: Container(
    width: 300,
    height: 200,
    child: Center(child: Text("Centered popup content")),
  ),
);
```

### BetterPicker - Picker

```dart
// Single-column picker
BetterPicker.show(
  context,
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
  context,
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
  context,
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
    titleText: 'Cell'.tr,
    isShowBorder: true,
    isShowArrowRight: true,
    onClick(){
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
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm'),
        content: Text('Do you want to toggle the switch?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          TextButton(
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

### BetterSwipeCell - Swipeable Cell

```dart
// Basic swipe cell with left and right actions
BetterSwipeCell(
  leftActions: [
    BetterSwipeCellAction(
      width: 60.bw,
      onClick: (value) async {
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
      onClick: (value) async {
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
      onClick: (value) async {
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
  //enable width extension
  //isStretch:true,
  child: BetterCell(
    height: 54.bw,
    titleText: 'Swipeable Cell',
    valueText: 'Content',
  ),
)

//async controll
BetterSwipeCell(
  rightActions: [
    BetterSwipeCellAction(
      width: 60.bw,
      value: '收藏',
      child: Container(
        color: Colors.blue,
        alignment: Alignment.center,
        child: Text(
          '收藏'.tr,
          style: TextStyle(color: Colors.white, fontSize: 14.bsp),
        ),
      ),
      onClick: (value) async {
        final result = await showCupertinoDialog<bool>(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text('标题'.tr),
            content: Text('是否收藏'.tr),
            actions: [
              CupertinoDialogAction(
                child: Text(
                  '取消'.tr,
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
                  '确定'.tr,
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
  child: BetterCell(height: 54.bw, titleText: '异步控制'.tr),
);
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

## 📋 Example Project

See the `example/` directory for full usage examples:

- `better_button_page.dart` - Button examples
- `better_toast_page.dart` - Toast examples
- `better_popup_page.dart` - Popup examples
- `better_picker_page.dart` - Picker examples
- `better_switch_page.dart` - Switch examples
- `better_cell_page.dart` - List cell examples
- `better_swipe_action.dart` - Swipe cell examples

## 🤝 Contributing

Issues and Pull Requests are welcome!

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

## 🔗 Links

- [Flutter](https://flutter.dev)
- [Dart](https://dart.dev)
- [Material Design](https://material.io/design)
