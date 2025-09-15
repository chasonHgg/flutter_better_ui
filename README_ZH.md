# Better UI

一个现代化的Flutter UI组件库，提供美观、易用的UI组件，支持主题定制和响应式设计。持续开发维护中...

## ✨ 特性

- 🎨 **现代化设计** - 采用Material Design 3设计语言
- 🌙 **主题支持** - 支持亮色/暗色主题切换
- 📱 **响应式** - 适配不同屏幕尺寸
- ⚡ **高性能** - 优化的渲染性能
- 🛠️ **易扩展** - 模块化设计，易于定制

## 🎥 预览
<div>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/1.gif" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/2.gif" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/3.gif" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/4.gif" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/5.gif" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/6.gif" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/7.gif" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/8.gif" width="200"/>
</div>




## 📦 组件列表

### 基础组件
- **BetterButton** - 增强版按钮组件，支持多种样式和状态
- **BetterTextButton** - 文本按钮组件
- **BetterCell** - 列表单元格组件

### 反馈组件
- **BetterToast** - 轻提示组件，支持多种位置和样式
- **BetterPopup** - 弹出层组件，支持多种弹出方式

### 表单组件
- **BetterPicker** - 选择器组件，支持单列、多列和级联选择
- **BetterSwitch** - 开关组件，支持自定义样式和异步控制
- **BetterDatePicker** - 日期选择器，具有灵活列类型和格式选项的日期选择器

### 反馈
- **BetterSwipeCell** - Swipeable cell with left and right action buttons

### 工具类
- **BetterScreenUtil** - 屏幕适配工具
- **ColorUtil** - 颜色处理工具

## 🚀 快速开始

### 安装

在 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  better_ui: ^lastversion
```

### 初始化

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

## 📖 使用指南

### BetterButton - 按钮组件

```dart
// 基础按钮
BetterButton(
  text: "点击我",
  onClick: () {
    print("按钮被点击");
  },
)

// 主要按钮
BetterButton(
  type: BetterButtonType.primary,
  text: "主要按钮",
  onClick: () {},
)

// 加载状态按钮
BetterButton(
  text: "加载中",
  loading: true,
  onClick: () {},
)

// 朴素按钮
BetterButton(
  type: BetterButtonType.primary,
  plain: true,
  text: "朴素按钮",
  onClick: () {},
)
```

### BetterToast - 轻提示

```dart
// 基础提示
BetterToast.show(
  context,
  message: "操作成功",
);

// 自定义样式
BetterToast.show(
  context,
  message: "自定义提示",
  backgroundColor: Colors.blue,
  textColor: Colors.white,
  position: BetterToastPosition.center,
  duration: Duration(seconds: 3),
);

// 加载提示
BetterToast.showLoading(context);
BetterToast.hideLoading();
```

### BetterPopup - 弹出层

```dart
// 底部弹出
BetterPopup.show(
  context,
  position: BetterPopupPosition.bottom,
  child: Container(
    height: 300,
    child: Center(child: Text("底部弹出内容")),
  ),
);

// 居中弹出
BetterPopup.show(
  context,
  position: BetterPopupPosition.center,
  child: Container(
    width: 300,
    height: 200,
    child: Center(child: Text("居中弹出内容")),
  ),
);
```

### BetterPicker - 选择器

```dart
// 单列选择器
BetterPicker.show(
  context,
  columns: [
    BetterPickerItem(text: '选项1', value: 'option1'),
    BetterPickerItem(text: '选项2', value: 'option2'),
    BetterPickerItem(text: '选项3', value: 'option3'),
  ],
  onConfirm: (items) {
    print("选择了: ${items.first.text}");
  },
);

// 多列选择器
BetterPicker.show(
  context,
  columns: [
    [
      BetterPickerItem(text: '周一', value: 'Monday'),
      BetterPickerItem(text: '周二', value: 'Tuesday'),
      BetterPickerItem(text: '周三', value: 'Wednesday'),
    ],
    [
      BetterPickerItem(text: '上午', value: 'Morning'),
      BetterPickerItem(text: '下午', value: 'Afternoon'),
      BetterPickerItem(text: '晚上', value: 'Evening'),
    ],
  ],
  onConfirm: (items) {
    print("选择了: ${items.map((item) => item.text).join(', ')}");
  },
);

// 级联选择器
BetterPicker.show(
  context,
  columns: [
    BetterPickerItem(
      text: '浙江',
      value: 'Zhejiang',
      children: [
        BetterPickerItem(
          text: '杭州',
          value: 'Hangzhou',
          children: [
            BetterPickerItem(text: '西湖区', value: 'Xihu'),
            BetterPickerItem(text: '余杭区', value: 'Yuhang'),
          ],
        ),
        BetterPickerItem(
          text: '温州',
          value: 'Wenzhou',
          children: [
            BetterPickerItem(text: '鹿城区', value: 'Lucheng'),
            BetterPickerItem(text: '瓯海区', value: 'Ouhai'),
          ],
        ),
      ],
    ),
  ],
  onConfirm: (items) {
    print("选择了: ${items.map((item) => item.text).join(' - ')}");
  },
);

```

### BetterSwitch - 开关组件

```dart
// 基础开关
BetterSwitch(
  onChanged: (value) {
    print("开关状态: $value");
  },
),

// 默认开启状态
BetterSwitch(
  defaultValue: true,
  onChanged: (value) {
    print("开关状态: $value");
  },
),

// 加载状态
BetterSwitch(
  loading: true,
  onChanged: (value) {
    print("开关状态: $value");
  },
),

// 自定义大小
BetterSwitch(
  width: 44.bw,
  height: 26.bw,
  onChanged: (value) {
    print("开关状态: $value");
  },
),

// 自定义颜色
BetterSwitch(
  defaultValue: true,
  activeBackgroundColor: Colors.red,
  inactiveBackgroundColor: Colors.grey,
  ballBackgroundColor: Colors.white,
  onChanged: (value) {
    print("开关状态: $value");
  },
),

// 自定义按钮
BetterSwitch(
  width: 50.bw,
  height: 30.bw,
  onChanged: (value) {
    setState(() {
      customBtnIsChecked = value;
    });
  },
  ballWidget: Container(
    width: 26.bw,
    height: 26.bw,
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
    ),
    child: Icon(
      customBtnIsChecked ? Icons.check : Icons.close,
      color: Theme.of(context).primaryColor,
      size: 16.bw,
    ),
  ),
),

// 禁用状态
BetterSwitch(
  disabled: true,
  onChanged: (value) {
    print("开关被禁用");
  },
),

// 异步控制
BetterSwitch(
  onUpdateChange: () async {
    // 显示确认对话框并等待用户选择
    final result = await showCupertinoDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('确认'),
        content: Text('是否切换开关？'),
        actions: [
          CupertinoDialogAction(
            child: Text('取消'),
            onPressed: () => Navigator.pop(context, false),
          ),
          CupertinoDialogAction(
            child: Text('确定'),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
    return result ?? false; // 返回用户选择结果
  },
),

// 配合单元格使用
BetterCell(
  titleText: '开关设置',
  valueWidget: BetterSwitch(
    width: 44.bw,
    height: 26.bw,
    onChanged: (value) {
      print("开关状态: $value");
    },
  ),
),
```

### BetterCell - 列表单元格

```dart
BetterCell(
    height: 44.bw,
    titleText: '单元格',
    isShowBorder: true,
    isShowArrowRight: true,
    onClick(){
        print("on click")
    }
),
```

### BetterSwipeCell - 滑动单元格

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
  //是否开启宽度延伸
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

### BetterDatePicker - 日期选择器

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

## 🔧 工具类

### BetterScreenUtil - 屏幕适配

```dart
// 获取屏幕信息
double screenWidth = BetterScreenUtil.screenWidth;
double screenHeight = BetterScreenUtil.screenHeight;
double statusBarHeight = BetterScreenUtil.statusBarHeight;

// 响应式尺寸
double responsiveWidth = 100.bw;
double responsiveHeight = 50.bh;
double responsiveFont = 16.bsp;
```

### ColorUtil - 颜色工具

```dart
// 颜色转换
Color hexColor = ColorUtil.hexToColor("#FF0000");
```

## 📋 示例项目

查看 `example/` 目录获取完整的使用示例：

- `better_button_page.dart` - 按钮组件示例
- `better_toast_page.dart` - 轻提示示例
- `better_popup_page.dart` - 弹出层示例
- `better_picker_page.dart` - 选择器示例
- `better_switch_page.dart` - 开关组件示例
- `better_cell_page.dart` - 列表单元格示例
- `better_swipe_action.dart` - 滑动单元格示例
- `better_date_picker_page.dart` - 滑动单元格示例

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 🔗 相关链接

- [Flutter 官网](https://flutter.dev)
- [Dart 官网](https://dart.dev)
- [Material Design](https://material.io/design)
