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
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/8.gif" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/9.gif" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/10.jpg" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/11.jpg" width="200"/>
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
- **BetterDatePicker** - Date picker with flexible column types and formatting options
- **BetterTimePicker** - Time picker with flexible column types and formatting options



### Feedback component
- **BetterSwipeCell** - Swipeable cell with left and right action buttons

### Display component
- **BetterSwiper** - Used to loop through a set of images or content
- **BetterMarquee** - Used for looping and displaying a set of message notifications.

### Utilities
- **BetterScreenUtil** - Screen adaptation utilities
- **ColorUtil** - Color utilities

## 🚀 Quick Start

### Installation

Add the dependency in `pubspec.yaml`:

```yaml
dependencies:
  flutter_better_ui: ^lastversion
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
  textStyle: TextStyle(color: Colors.red),
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

//Customer button
BetterButton(
  backgroundColor: Colors.red,
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.add, color: Colors.white),
      Text('Customer', style: TextStyle(color: Colors.white)),
    ],
  ),
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
    titleText: 'Cell',
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
          '收藏',
          style: TextStyle(color: Colors.white, fontSize: 14.bsp),
        ),
      ),
      onClick: (value) async {
        final result = await showCupertinoDialog<bool>(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text('标题'),
            content: Text('是否收藏'),
            actions: [
              CupertinoDialogAction(
                child: Text(
                  '取消',
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
                  '确定',
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
  child: BetterCell(height: 54.bw, titleText: '异步控制'),
);
```


### BetterDatePicker - Date Picker

```dart
// Basic date picker
BetterDatePicker.show(
  context,
  title: "选择日期",
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("Selected date: ${selectedValues.map((e) => e.value).join('-')}");
  },
);

// Date picker with custom range
BetterDatePicker.show(
  context,
  title: "选择日期",
  minDate: [2022, 1, 1],
  maxDate: [2024, 12, 31],
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("Selected date: ${selectedValues.map((e) => e.value).join('-')}");
  },
);

// Date picker with custom formatting
BetterDatePicker.show(
  context,
  title: "选择日期",
  formatter: (BetterDatePickerFormatterOption option) {
    if (option.columnType == BetterDatePickerColumnType.year) {
      return "${option.text}年";
    }
    if (option.columnType == BetterDatePickerColumnType.month) {
      return "${option.text}月";
    }
    if (option.columnType == BetterDatePickerColumnType.day) {
      return "${option.text}日";
    }
    return option.text;
  },
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("Selected date: ${selectedValues.map((e) => e.value).join('-')}");
  },
);

// Date picker with specific column types (year and month only)
BetterDatePicker.show(
  context,
  title: "选择年月",
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
  context,
  title: "选择日期",
  defaultValue: [2025, 9, 8],
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("Selected date: ${selectedValues.map((e) => e.value).join('-')}");
  },
);

// Date picker with filtering (e.g., only show months divisible by 6)
BetterDatePicker.show(
  context,
  title: "选择日期",
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
  context,
  title: "选择日期",
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
  context,
  title: "选择时间",
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("Selected time: ${selectedValues.map((e) => e.value).join(':')}");
  },
);

// Time picker with custom range
BetterTimePicker.show(
  context,
  title: "选择时间",
  minDate: [10, 0, 0],
  maxDate: [18, 59, 59],
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("Selected time: ${selectedValues.map((e) => e.value).join(':')}");
  },
);

// Time picker with custom formatting
BetterTimePicker.show(
  context,
  title: "选择时间",
  formatter: (BetterTimePickerFormatterOption option) {
    if (option.columnType == BetterTimePickerColumnType.hour) {
      return "${option.text}时";
    }
    if (option.columnType == BetterTimePickerColumnType.minute) {
      return "${option.text}分";
    }
    if (option.columnType == BetterTimePickerColumnType.second) {
      return "${option.text}秒";
    }
    return option.text;
  },
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("Selected time: ${selectedValues.map((e) => e.value).join(':')}");
  },
);

// Time picker with specific column types (hour and minute only)
BetterTimePicker.show(
  context,
  title: "选择时分",
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
  context,
  title: "选择时间",
  defaultValue: [14, 30, 0],
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("Selected time: ${selectedValues.map((e) => e.value).join(':')}");
  },
);

// Time picker with filtering (e.g., only show minutes divisible by 5)
BetterTimePicker.show(
  context,
  title: "选择时间",
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
  context,
  title: "选择时间",
  isDefaultShowNow: false,
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("Selected time: ${selectedValues.map((e) => e.value).join(':')}");
  },
);
```

### BetterSwiper - 轮播

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

## Questions

- Why is the click area of buttons in lists such as ListView very large？Please use its properties or components, such as Align


## 📋 Example Project

See the `example/` directory for full usage examples:

- `better_button_page.dart` - Button examples
- `better_toast_page.dart` - Toast examples
- `better_popup_page.dart` - Popup examples
- `better_picker_page.dart` - Picker examples
- `better_switch_page.dart` - Switch examples
- `better_cell_page.dart` - List cell examples
- `better_swipe_action_page.dart` - Swipe cell examples
- `better_date_picker_page.dart` - Date picker examples
- `better_time_picker_page.dart` - Time picker examples
- `better_swiper_page.dart` - swiper examples

## 🤝 Contributing

Issues and Pull Requests are welcome!

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

## 🔗 Links

- [Flutter](https://flutter.dev)
- [Dart](https://dart.dev)
- [Material Design](https://material.io/design)
