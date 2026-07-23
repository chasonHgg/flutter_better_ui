import 'package:flutter/material.dart';
import 'package:flutter_better_ui/better_button.dart';
import 'package:flutter_better_ui/better_toast.dart';
import 'package:flutter_better_ui/better_ui.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';

class BetterPopoverPage extends StatelessWidget {
  const BetterPopoverPage({super.key});

  List<BetterPopoverAction> _actions() => [
    BetterPopoverAction(text: '选项一'.tr, icon: const Icon(Icons.add)),
    BetterPopoverAction(text: '选项二'.tr, icon: const Icon(Icons.music_note)),
    BetterPopoverAction(
      text: '禁用选项'.tr,
      icon: const Icon(Icons.block),
      disabled: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('气泡弹出框'.tr)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.bw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title('基础用法'.tr),
            BetterPopover(
              actions: _actions(),
              enableAnimation: true,
              onSelect: (action) => BetterToast.show(
                context: context,
                message: '${'已选择'.tr} ${action.text}',
              ),
              child: BetterButton(text: '点击显示'.tr),
            ),
            _title('弹出位置'.tr),
            ...[
              ('上方居中'.tr, BetterPopoverPlacement.top),
              ('上方左对齐'.tr, BetterPopoverPlacement.topStart),
              ('上方右对齐'.tr, BetterPopoverPlacement.topEnd),
              ('下方居中'.tr, BetterPopoverPlacement.bottom),
              ('下方左对齐'.tr, BetterPopoverPlacement.bottomStart),
              ('下方右对齐'.tr, BetterPopoverPlacement.bottomEnd),
              ('左侧居中'.tr, BetterPopoverPlacement.left),
              ('左侧顶部对齐'.tr, BetterPopoverPlacement.leftStart),
              ('左侧底部对齐'.tr, BetterPopoverPlacement.leftEnd),
              ('右侧居中'.tr, BetterPopoverPlacement.right),
              ('右侧顶部对齐'.tr, BetterPopoverPlacement.rightStart),
              ('右侧底部对齐'.tr, BetterPopoverPlacement.rightEnd),
            ].map(
              (item) => Padding(
                padding: EdgeInsets.only(bottom: 12.bw),
                child: Center(child: _placementButton(item.$1, item.$2)),
              ),
            ),
            _title('显示遮罩'.tr),
            BetterPopover(
              actions: _actions(),
              overlay: true,
              child: BetterButton(text: '显示遮罩'.tr),
            ),
            _title('自定义内容'.tr),
            BetterPopover(
              width: 220.bw,
              padding: EdgeInsets.all(16.bw),
              content: Text('这是自定义内容'.tr),
              child: BetterButton(text: '自定义内容'.tr),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title(String text) => Padding(
    padding: EdgeInsets.only(top: 20.bw, bottom: 12.bw),
    child: Text(text, style: TextStyle(fontSize: 14.bsp)),
  );

  Widget _placementButton(String text, BetterPopoverPlacement placement) {
    return BetterPopover(
      actions: _actions(),
      placement: placement,
      child: BetterButton(text: text),
    );
  }
}
