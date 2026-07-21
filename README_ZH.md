# Better UI

[English](https://github.com/chasonHgg/flutter_better_ui/blob/main/README.md)

一个现代化的 Flutter UI 组件库，提供美观、易用的 UI 组件，支持主题定制和响应式设计。持续开发维护中。

## ✨ 特性

- 🎨 **现代化设计** - 采用 Material Design 3 设计语言
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
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/14.png" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/15.png" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/16.png" width="200"/>
  <img src="https://raw.githubusercontent.com/chasonHgg/flutter_better_ui/refs/heads/main/readme_assets/17.gif" width="200"/>
</div>

## 📦 组件列表

### 基础组件

- **BetterButton** - 增强版按钮组件，支持多种样式和状态
- **BetterTextButton** - 文本按钮组件
- **BetterCell** - 列表单元格组件

### 反馈组件

- **BetterToast** - 轻提示组件，支持多种位置和样式
- **BetterPopup** - 弹出层组件，支持多种弹出方式
- **BetterDialog** - 弹出框组件，支持提示、确认和主题定制

### 表单组件

- **BetterPicker** - 选择器组件，支持单列、多列和级联选择
- **BetterSwitch** - 开关组件，支持自定义样式和异步控制
- **BetterDatePicker** - 日期选择器，支持灵活的列类型和格式选项
- **BetterTimePicker** - 时间选择器，支持灵活的列类型和格式选项

### 操作组件

- **BetterSwipeCell** - 带有左右操作按钮的可滑动单元格
- **BetterSlideAction** - 滑动完成按钮，支持反向滑动和控制器复位

### 展示组件

- **BetterSwiper** - 用于循环播放一组图片或内容
- **BetterImagePreview** - 全屏图片预览，支持翻页、手势缩放和自定义状态
- **BetterMarquee** - 用于循环播放展示一组消息通知
- **BetterCollapse** - 折叠面板组件，用于展示和隐藏分组内容
- **BetterSkeletonizer** - 骨架屏组件，可根据子组件布局自动绘制占位内容

### 工具类

- **BetterScreenUtil** - 屏幕适配工具
- **ColorUtil** - 颜色处理工具
- **BetterAssets** - 根据图片目录生成 Dart 资源常量类

## 🚀 快速开始

### 安装

在 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  flutter_better_ui: ^2.0.18
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
      // 必须指定
      navigatorKey: BetterUi.navigatorKey,
      home: HomePage(),
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
  onTap: () {
    print("按钮被点击");
  },
)

// 主要按钮
BetterButton(
  type: BetterButtonType.primary,
  text: "主要按钮",
  onTap: () {},
)

// 加载状态按钮
BetterButton(
  text: "加载中",
  loading: true,
  onTap: () {},
)

// 朴素按钮
BetterButton(
  type: BetterButtonType.primary,
  plain: true,
  text: "朴素按钮",
  onTap: () {},
)

// 自定义按钮
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

### BetterDialog - 弹出框

```dart
// 提示弹窗
BetterDialog.showDialog(
  title: "提示弹窗",
  content: "这是提示弹窗内容",
);

// 无标题提示弹窗
BetterDialog.showDialog(
  content: "这是无标题提示弹窗内容",
);

// 确认弹窗
BetterDialog.showDialog(
  title: "确认",
  content: "确定要继续吗？",
  showCancelButton: true,
  onConfirm: () {
    print("点击确认");
  },
  onCancel: () {
    print("点击取消");
  },
);

// 自定义底部内容
BetterDialog.showDialog(
  title: "自定义按钮",
  content: "使用自定义按钮区域",
  buttomWidget: Padding(
    padding: EdgeInsets.only(bottom: 10, left: 16, right: 16),
    child: BetterButton(
      width: double.infinity,
      text: "确认",
      textStyle: TextStyle(color: Colors.white),
      decoration: BoxDecoration(color: Colors.red),
      onTap: () {
        Navigator.of(context).pop();
      },
    ),
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
  onTap: () {
    print("点击单元格");
  },
),
```

### BetterSwipeCell - 滑动单元格

```dart
// 左右滑动操作
BetterSwipeCell(
  leftActions: [
    BetterSwipeCellAction(
      width: 60.bw,
      onTap: (value) async {
        return true;
      },
      child: Container(
        color: Colors.blue,
        alignment: Alignment.center,
        child: Text(
          '收藏',
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
        alignment: Alignment.center,
        child: Text(
          '删除',
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
          '收藏',
          style: TextStyle(color: Colors.white, fontSize: 14.bsp),
        ),
      ),
    ),
  ],
  // 是否开启宽度延伸
  // isStretch: true,
  child: BetterCell(
    height: 54.bw,
    titleText: '滑动单元格',
    valueText: '内容',
  ),
)

// 异步控制
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
      onTap: (value) async {
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

### BetterSlideAction - 滑动按钮

```dart
// 基础用法
BetterSlideAction(
  color: Theme.of(context).primaryColor,
  onCompleted: () {
    BetterToast.showSuccess(message: '完成');
  },
  knobChild: Icon(Icons.chevron_right),
  children: Text(
    '向右滑动完成',
    style: TextStyle(color: Colors.white),
  ),
)

// 反向滑动，从右向左滑动完成
BetterSlideAction(
  reverse: true,
  color: Colors.orange,
  onCompleted: () {
    BetterToast.showSuccess(message: '完成');
  },
  knobChild: Icon(Icons.chevron_left),
  children: Text(
    '向左滑动完成',
    style: TextStyle(color: Colors.white),
  ),
)

// 自定义样式并完成后自动复位
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
    BetterToast.showSuccess(message: '完成');
  },
  knobChild: Icon(Icons.lock_open),
  children: Text(
    '滑动解锁',
    style: TextStyle(color: Colors.white),
  ),
)

// 使用控制器手动复位
final controller = BetterSlideActionController();

BetterSlideAction(
  controller: controller,
  color: Colors.blue,
  onCompleted: () {
    BetterToast.showSuccess(message: '完成');
  },
  knobChild: Icon(Icons.check),
  children: Text(
    '可手动复位',
    style: TextStyle(color: Colors.white),
  ),
)

BetterButton(
  type: BetterButtonType.primary,
  text: '重置',
  onTap: controller.reset,
)
```

### BetterDatePicker - 日期选择器

```dart
// 基础日期选择器
BetterDatePicker.show(
  title: "选择日期",
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("选择的日期: ${selectedValues.map((e) => e.value).join('-')}");
  },
);

// 自定义日期范围
BetterDatePicker.show(
  title: "选择日期",
  minDate: [2022, 1, 1],
  maxDate: [2024, 12, 31],
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("选择的日期: ${selectedValues.map((e) => e.value).join('-')}");
  },
);

// 自定义格式化
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
    print("选择的日期: ${selectedValues.map((e) => e.value).join('-')}");
  },
);

// 指定列类型（仅选择年月）
BetterDatePicker.show(
  title: "选择年月",
  columnTypes: [
    BetterDatePickerColumnType.year,
    BetterDatePickerColumnType.month,
  ],
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("选择的年月: ${selectedValues.map((e) => e.value).join('-')}");
  },
);

// 设置默认值
BetterDatePicker.show(
  title: "选择日期",
  defaultValue: [2025, 9, 8],
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("选择的日期: ${selectedValues.map((e) => e.value).join('-')}");
  },
);

// 过滤选项（例如：只显示能被 6 整除的月份）
BetterDatePicker.show(
  title: "选择日期",
  columnTypes: [
    BetterDatePickerColumnType.year,
    BetterDatePickerColumnType.month,
  ],
  filter: (BetterDatePickerFilterOption option) {
    if (option.columnType == BetterDatePickerColumnType.month) {
      return option.value % 6 == 0; // 只显示 6 月和 12 月
    }
    return true;
  },
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("选择的日期: ${selectedValues.map((e) => e.value).join('-')}");
  },
);

// 不默认显示今天
BetterDatePicker.show(
  title: "选择日期",
  isDefaultShowToday: false,
  onConfirm: (List<BetterPickerItem> selectedValues) {
    print("选择的日期: ${selectedValues.map((e) => e.value).join('-')}");
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

### BetterImagePreview - 图片预览

`BetterImagePreview` 使用 `PageView.builder` 按需构建页面，并预缓存当前图片的前后相邻图片。以 `http://` 或 `https://` 开头的地址使用网络图片加载，其余字符串按 Flutter Asset 路径处理。

```dart
// 基础用法，images 是必传参数
await BetterImagePreview.show(
  context: context, // 可省略，默认使用 BetterUi.currentContext
  images: const [
    'assets/images/cat.jpeg',
    'https://example.com/image-1.jpg',
    'https://example.com/image-2.jpg',
  ],
  startPosition: 0,
  onChange: (index) {
    print('当前图片：$index');
  },
  onClose: (index) {
    print('关闭时的图片：$index');
  },
);
```

纵向切换及缩放控制：

```dart
BetterImagePreview.show(
  images: images,
  vertical: true,     // 上下切换，默认 false
  doubleScale: false, // 关闭双击缩放，双指缩放仍可使用
  closeOnTap: false,
  closeable: true,
);
```

图片放大后可单指移动；移动到边缘并继续拖动即可切换上一张或下一张，横向和纵向模式均支持。

自定义页码：

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

自定义图片外观、加载和失败状态：

组件默认显示白色加载指示器和加载失败图标；传入对应 Builder 后会替换默认状态。`imageBuilder` 用于包装内置图片，其 `child` 应保留在返回的组件树中。

```dart
BetterImagePreview.show(
  images: images,
  imageBuilder: (context, image, index, child) {
    // child 是内置图片，必须保留才能显示图片及加载/失败状态
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

主要参数：

| 参数 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `context` | `BuildContext?` | `BetterUi.currentContext` | 路由上下文 |
| `images` | `List<String>` | 必传 | 网络图片地址或 Asset 路径，不能为空 |
| `startPosition` | `int` | `0` | 初始图片索引，越界时自动限制到有效范围 |
| `loop` | `bool` | `true` | 是否循环切换 |
| `vertical` | `bool` | `false` | 是否使用上下切换 |
| `doubleScale` | `bool` | `true` | 是否启用双击放大/还原 |
| `minScale` / `maxScale` | `double` | `1` / `4` | 最小、最大缩放比例 |
| `showIndex` | `bool` | `true` | 是否显示页码 |
| `closeable` | `bool` | `false` | 是否显示关闭按钮 |
| `closeOnTap` | `bool` | `true` | 是否点击图片关闭 |
| `closePosition` | `BetterImagePreviewClosePosition` | `topRight` | 关闭按钮位置 |
| `backgroundColor` | `Color` | `Colors.black` | 预览背景色 |
| `transitionDuration` | `Duration` | `250ms` | 打开、关闭的淡入淡出时长 |
| `onChange` / `onClose` | `ValueChanged<int>?` | `null` | 图片变化和预览关闭回调，参数为图片索引 |
| `indexBuilder` | `Widget Function(...)` | `null` | 自定义页码；未传时显示默认页码 |
| `imageBuilder` | `Widget Function(...)` | `null` | 包装内置图片组件 |
| `loadingBuilder` / `errorBuilder` | `Widget Function(...)` | `null` | 自定义加载中和加载失败状态 |

关闭按钮的语义提示读取 Flutter `MaterialLocalizations`，无需依赖特定的多语言库。

### BetterCollapse - 折叠面板

```dart
// 基础折叠面板
BetterCollapse(
  children: BetterCollapseItem(
    title: Text('标题'),
    children: [
      Text('内容 1'),
      Text('内容 2'),
    ],
  ),
)

// 多个折叠面板
Column(
  children: [
    BetterCollapse(
      children: BetterCollapseItem(
        title: Text('标题 1'),
        children: [Text('内容 1')],
      ),
    ),
    BetterCollapse(
      children: BetterCollapseItem(
        title: Text('标题 2'),
        children: [Text('内容 2')],
      ),
    ),
  ],
)

// 外部控制展开和收起
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
              child: Text('展开'),
            ),
            ElevatedButton(
              onPressed: _controller.collapse,
              child: Text('收起'),
            ),
          ],
        ),
        BetterCollapse(
          expansibleController: _controller,
          children: BetterCollapseItem(
            title: Text('标题'),
            children: [Text('内容')],
          ),
        ),
      ],
    );
  }
}

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
  children: BetterCollapseItem(
    title: Text('自定义标题'),
    children: [Text('自定义内容')],
  ),
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
| `expansibleController` | 从外部控制面板，例如展开和收起 |
| `titlePadding` | 标题区域内边距 |
| `minTitleHeight` | 标题区域最小高度 |
| `titleMinVerticalPadding` | 去除或自定义标题内部 ListTile 的垂直内边距 |
| `background` | 展开状态背景色 |
| `collapsedBackground` | 未展开状态背景色 |
| `iconColor` | 展开状态箭头颜色 |
| `collapsedIconColor` | 未展开状态箭头颜色 |
| `splashColor` | 点击标题区域时的水波纹颜色 |
| `contentPadding` | 展开内容区域内边距 |


### BetterSkeletonizer - 骨架屏

`BetterSkeletonizer` 会保留原有子组件布局，并在 `enabled` 为 true 时把绘制替换成骨架占位。它可以包裹普通组件，也可以包裹滚动列表，并保留 Flutter 原生懒加载逻辑。

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
        title: Text('标题 $index'),
        subtitle: Text('骨架屏会保留原有布局。'),
      );
    },
  ),
)
```

接口请求完成后，将 `enabled` 设为 `false`，即可恢复原组件绘制：

```dart
setState(() {
  loading = false;
});
```

#### 自定义颜色和动画

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

#### BetterSkeletonizer 属性

| 属性 | 说明 |
| --- | --- |
| `enabled` | 是否显示骨架占位 |
| `child` | 原始内容，仍会参与布局和滚动 |
| `baseColor` | 强制指定骨架颜色，会覆盖亮色/暗色默认色 |
| `lightBaseColor` | 亮色模式骨架颜色，`baseColor` 为空时生效 |
| `darkBaseColor` | 暗色模式骨架颜色，`baseColor` 为空时生效 |
| `fadeDuration` | 透明度循环动画周期 |
| `minOpacity` | 透明度循环动画最小透明度 |
| `maxOpacity` | 透明度循环动画最大透明度 |
| `textBorderRadius` | 文本骨架条的圆角 |
| `defaultBorderRadius` | 通用骨架占位的默认圆角 |
| `ignorePointers` | 骨架开启时是否忽略子组件手势，默认 `false`，列表可继续滚动 |

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


### BetterAssets - 资源常量生成工具

`BetterAssets` 会扫描目录，并生成一个包含静态资源路径常量的 Dart 类。

```dart
import 'package:flutter_better_ui/utils/better_assets.dart';

void main() async {
  test('RefreshImages', () async {
    await BetterAssets.generate(
      projectPath: '.', // 可选，默认向上查找最近的 pubspec.yaml 所在目录
      imagePath: 'assets/images',
      codePath: 'lib/app_res',
      codeName: 'app_image',
      className: 'AppImages',
    );
  }
}
```

## ❓ 常见问题

- **为什么 `ListView` 等列表中的按钮点击区域很大？**

  可以使用 `Align` 等布局组件包裹按钮，或显式设置按钮的宽度、高度和内边距。

## 📋 示例项目

查看 `example/` 目录获取完整的使用示例：

- `better_button_page.dart` - 按钮组件示例
- `better_toast_page.dart` - 轻提示示例
- `better_popup_page.dart` - 弹出层示例
- `better_dialog_page.dart` - 弹出框示例
- `better_picker_page.dart` - 选择器示例
- `better_switch_page.dart` - 开关组件示例
- `better_cell_page.dart` - 列表单元格示例
- `better_swipe_action_page.dart` - 滑动单元格示例
- `better_slide_action_page.dart` - 滑动按钮示例
- `better_date_picker_page.dart` - 日期选择器示例
- `better_time_picker_page.dart` - 时间选择器示例
- `better_swiper_page.dart` - 轮播示例
- `better_image_preview_page.dart` - 图片预览示例
- `better_marquee_page.dart` - 跑马灯示例
- `better_collapse_page.dart` - 折叠面板示例
- `better_skeleton_page.dart` - 骨架屏示例

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 🔗 相关链接

- [Flutter 官网](https://flutter.dev)
- [Dart 官网](https://dart.dev)
- [Material Design](https://material.io/design)
