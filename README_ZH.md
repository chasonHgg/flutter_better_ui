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
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/9.gif" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/10.jpg" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/11.jpg" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/12.gif" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/13.png" width="200"/>
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
- **BetterTimePicker** - 时间选择器，具有灵活列类型和格式选项的时间选择器

### 反馈组件
- **BetterSwipeCell** - 带有左右操作按钮的可滑动单元格

### 展示组件
- **BetterSwiper** - 用于循环播放一组图片或内容
- **BetterMarquee** - 用于循环播放展示一组消息通知。
- **BetterCollapse** - 折叠面板组件，用于展示和隐藏分组内容

### 工具类
- **BetterScreenUtil** - 屏幕适配工具
- **ColorUtil** - 颜色处理工具

## 🚀 快速开始

### 安装

在 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  flutter_better_ui: ^lastversion
```

### 初始化

```dart
void main() async {
  runApp(BetterUi(designWidth: 375, designHeight: 812, child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //必须指定
      navigatorKey: BetterUi.navigatorKey,
      home: HomePage();
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
  textStyle: TextStyle(color: Colors.red),
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

//自定义按钮
BetterButton(
  decoration: BoxDecoration(
    color: Colors.red,
  ),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.add, color: Colors.white),
      Text('自定义内容'.tr, style: TextStyle(color: Colors.white)),
    ],
  ),
)
```

### BetterToast - 轻提示

```dart
// 基础提示
BetterToast.show(
  message: "操作成功",
);

// 自定义样式
BetterToast.show(
  message: "自定义提示",
  backgroundColor: Colors.blue,
  textColor: Colors.white,
  position: BetterToastPosition.center,
  duration: Duration(seconds: 3),
);

// 加载提示
BetterToast.showLoading();
BetterToast.hideLoading();
```

### BetterPopup - 弹出层

```dart
// 底部弹出
BetterPopup.show(
  position: BetterPopupPosition.bottom,
  child: Container(
    height: 300,
    child: Center(child: Text("底部弹出内容")),
  ),
);

// 居中弹出
BetterPopup.show(
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
  title: "选择日期",
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("Selected date: ${selectedValues.map((e) => e.value).join('-')}");
  },
);

// Date picker with custom range
BetterDatePicker.show(
  title: "选择日期",
  minDate: [2022, 1, 1],
  maxDate: [2024, 12, 31],
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("Selected date: ${selectedValues.map((e) => e.value).join('-')}");
  },
);

// Date picker with custom formatting
BetterDatePicker.show(
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
  title: "选择日期",
  defaultValue: [2025, 9, 8],
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("Selected date: ${selectedValues.map((e) => e.value).join('-')}");
  },
);

// Date picker with filtering (e.g., only show months divisible by 6)
BetterDatePicker.show(
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
  title: "选择日期",
  isDefaultShowToday: false,
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("Selected date: ${selectedValues.map((e) => e.value).join('-')}");
  },
);
```

### BetterTimePicker - 时间选择器

```dart
// 基础时间选择器
BetterTimePicker.show(
  title: "选择时间",
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("选择的时间: ${selectedValues.map((e) => e.value).join(':')}");
  },
);

// 自定义时间范围的时间选择器
BetterTimePicker.show(
  title: "选择时间",
  minDate: [10, 0, 0],
  maxDate: [18, 59, 59],
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("选择的时间: ${selectedValues.map((e) => e.value).join(':')}");
  },
);

// 自定义格式化的时间选择器
BetterTimePicker.show(
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
    print("选择的时间: ${selectedValues.map((e) => e.value).join(':')}");
  },
);

// 指定列类型的时间选择器（仅选择时分）
BetterTimePicker.show(
  title: "选择时分",
  columnTypes: [
    BetterTimePickerColumnType.hour,
    BetterTimePickerColumnType.minute,
  ],
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("选择的时分: ${selectedValues.map((e) => e.value).join(':')}");
  },
);

// 设置默认值的时间选择器
BetterTimePicker.show(
  title: "选择时间",
  defaultValue: [14, 30, 0],
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("选择的时间: ${selectedValues.map((e) => e.value).join(':')}");
  },
);

// 带过滤功能的时间选择器（例如：只显示能被5整除的分钟）
BetterTimePicker.show(
  title: "选择时间",
  columnTypes: [
    BetterTimePickerColumnType.hour,
    BetterTimePickerColumnType.minute,
  ],
  filter: (BetterTimePickerFilterOption option) {
    if (option.columnType == BetterTimePickerColumnType.minute) {
      return option.value % 5 == 0; // 只显示分钟 0, 5, 10, 15 等
    }
    return true;
  },
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("选择的时间: ${selectedValues.map((e) => e.value).join(':')}");
  },
);

// 不默认显示当前时间的时间选择器
BetterTimePicker.show(
  title: "选择时间",
  isDefaultShowNow: false,
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("选择的时间: ${selectedValues.map((e) => e.value).join(':')}");
  },
);
```

### BetterSwiper - 轮播图

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

### BetterCollapse - 折叠面板

```dart
// 基础折叠面板
BetterCollapse(
  children: [
    BetterCollapseItem(
      title: Text('标题 1'),
      children: [
        Text('内容 1'),
        Text('内容 2'),
      ],
    ),
    BetterCollapseItem(
      title: Text('标题 2'),
      children: [
        Text('内容 3'),
      ],
    ),
  ],
)

// 手风琴模式：打开一个面板时关闭上一个面板
BetterCollapse(
  accordion: true,
  children: [
    BetterCollapseItem(
      title: Text('标题 1'),
      children: [Text('内容 1')],
    ),
    BetterCollapseItem(
      title: Text('标题 2'),
      children: [Text('内容 2')],
    ),
  ],
)

// 自定义标题区域、背景、水波纹和箭头颜色
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
  children: [
    BetterCollapseItem(
      title: Text('自定义标题'),
      children: [Text('自定义内容')],
    ),
  ],
)
```

#### BetterCollapse 主题配置

```dart
ThemeData(
  extensions: [
    BetterThemeExtension(
      // ...其它主题字段
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

| 属性 | 说明 |
| --- | --- |
| `accordion` | 是否同一时间只允许展开一个面板 |
| `titlePadding` | 标题区域内边距 |
| `minTitleHeight` | 标题区域最小高度 |
| `titleMinVerticalPadding` | 去除或自定义标题内部 ListTile 的垂直内边距 |
| `background` | 展开状态背景色 |
| `collapsedBackground` | 未展开状态背景色 |
| `iconColor` | 展开状态箭头颜色 |
| `collapsedIconColor` | 未展开状态箭头颜色 |
| `splashColor` | 点击标题区域时的水波纹颜色 |
| `contentPadding` | 展开内容区域内边距 |

### BetterMarquee - 跑马灯

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

### BetterIndexBar - 索引栏

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
        color:ColorUtil.hexToColor("#fff"),
        child: Text("我是自定义内容"),
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

## 问题

- 为什么ListView等列表中按钮的点击区域很大? 请使用对其属性或组件,例如Align

## 📋 示例项目

查看 `example/` 目录获取完整的使用示例：

- `better_button_page.dart` - 按钮组件示例
- `better_toast_page.dart` - 轻提示示例
- `better_popup_page.dart` - 弹出层示例
- `better_picker_page.dart` - 选择器示例
- `better_switch_page.dart` - 开关组件示例
- `better_cell_page.dart` - 列表单元格示例
- `better_swipe_action_page.dart` - 滑动单元格示例
- `better_date_picker_page.dart` - 日期选择器示例
- `better_time_picker_page.dart` - 时间选择器示例
- `better_swiper_page.dart` - 轮播示例
- `better_marquee_page.dart` - 跑马灯示例
- `better_collapse_page.dart` - 折叠面板示例

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 🔗 相关链接

- [Flutter 官网](https://flutter.dev)
- [Dart 官网](https://dart.dev)
- [Material Design](https://material.io/design)
