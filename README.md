# Better UI

一个现代化的Flutter UI组件库，提供美观、易用的UI组件，支持主题定制和响应式设计。持续开发维护中...

## ✨ 特性

- 🎨 **现代化设计** - 采用Material Design 3设计语言
- 🌙 **主题支持** - 支持亮色/暗色主题切换
- 📱 **响应式** - 适配不同屏幕尺寸
- ⚡ **高性能** - 优化的渲染性能
- 🛠️ **易扩展** - 模块化设计，易于定制

## 🎥 预览

[![Video](https://img.shields.io/badge/Better%20UI-Demo-blue?style=for-the-badge&logo=flutter)](https://github.com/user-attachments/assets/5221f499-c5eb-4e2b-a32c-c6a12e0cb5f8)

![Image](https://github.com/user-attachments/assets/04390834-990c-4f22-8e6f-a0a459dc4019)

![Image](https://github.com/user-attachments/assets/ffd34475-4c4d-46cb-ade2-f1379abc88a7)

![Image](https://github.com/user-attachments/assets/0689287c-94f8-4ade-8c3d-c8654f2f2ce3)


## 📦 组件列表

### 基础组件i
- **BetterButton** - 增强版按钮组件，支持多种样式和状态
- **BetterTextButton** - 文本按钮组件
- **BetterCell** - 列表单元格组件

### 反馈组件
- **BetterToast** - 轻提示组件，支持多种位置和样式
- **BetterPopup** - 弹出层组件，支持多种弹出方式

### 表单组件
- **BetterPicker** - 选择器组件，支持单列、多列和级联选择

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

### BetterCell - 列表单元格

```dart
BetterCell(
    height: 44.bw,
    titleText: '单元格'.tr,
    isShowBorder: true,
    isShowArrowRight: true,
    onClick(){
        print("on click")
    }
),
```

## 📱 响应式设计

Better UI 内置响应式工具类：

```dart
// 使用响应式尺寸
Container(
  width: 100.bw,
  height: 50.bh,
  child: Text(
    "响应式文本",
    style: TextStyle(fontSize: 16.bsp),
  ),
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

## 📋 示例项目

查看 `example/` 目录获取完整的使用示例：

- `better_button_page.dart` - 按钮组件示例
- `better_toast_page.dart` - 轻提示示例
- `better_popup_page.dart` - 弹出层示例
- `better_picker_page.dart` - 选择器示例
- `better_cell_page.dart` - 列表单元格示例

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 🔗 相关链接

- [Flutter 官网](https://flutter.dev)
- [Dart 官网](https://dart.dev)
- [Material Design](https://material.io/design)
