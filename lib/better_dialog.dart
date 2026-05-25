import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_ui/better_button.dart';
import 'package:flutter_better_ui/better_ui.dart';
import 'package:flutter_better_ui/theme/child_themes/better_dialog_theme.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:flutter_better_ui/utils/better_util.dart';
import 'package:flutter_better_ui/utils/color_util.dart';

class BetterDialog {
  static showDialog({
    BuildContext? context,
    bool barrierDismissible = true,
    Color? barrierColor,
    String? title,
    String? content,
    bool showConfirmButton = true,
    bool showCancelButton = false,
    String confirmButtonText = "确认",
    Color? confirmButtonColor,
    bool confirmButtonDisabled = false,
    String cancelButtonText = "取消",
    Color? cancelButtonColor,
    bool cancelButtonDisabled = false,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool isCloseWhenTap = true,
    Widget? buttomWidget
  }) {
    final betterDialogContext = context ?? BetterUi.currentContext;
    if (betterDialogContext == null) {
      return;
    }
    showCupertinoDialog(
      context: betterDialogContext,
      barrierDismissible: barrierDismissible,
      barrierColor:
          barrierColor ?? ColorUtil.hexToColor("#000000").withAlpha(178),
      builder: (context) {
        final dialogTheme = BetterUtil.getThemeExtension(context)!.dialogTheme;
        final bgColor = dialogTheme.bgColor ?? Colors.white;

        return Center(
          child: CupertinoPopupSurface(
            isSurfacePainted: false,
            child: Container(
              color: bgColor,
              child: SizedBox(
                width: 320.bw,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 26.bw),
                    if (title != null)
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16.bsp,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.none,
                          color:
                              dialogTheme.titleColor ??
                              ColorUtil.hexToColor("#323232"),
                        ),
                      ),
                    if (content != null)
                      Padding(
                        padding: EdgeInsetsGeometry.only(
                          top: 8.bw,
                          left: 26.bw,
                          right: 26.bw,
                          bottom: 26.bw,
                        ),
                        child: Text(
                          content,
                          style: TextStyle(
                            fontSize: 14.bsp,
                            decoration: TextDecoration.none,
                            color:
                                dialogTheme.contentColor ??
                                ColorUtil.hexToColor("#646566"),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    if(buttomWidget!=null)buttomWidget,
                    if ((showCancelButton || showConfirmButton) && buttomWidget==null)
                      _renderDefaultButton(
                        context: context,
                        dialogTheme: dialogTheme,
                        showConfirmButton: showConfirmButton,
                        showCancelButton: showCancelButton,
                        confirmButtonText: confirmButtonText,
                        confirmButtonColor: confirmButtonColor,
                        confirmButtonDisabled: confirmButtonDisabled,
                        cancelButtonText: cancelButtonText,
                        cancelButtonColor: cancelButtonColor,
                        cancelButtonDisabled: cancelButtonDisabled,
                        onConfirm: onConfirm,
                        onCancel: onCancel,
                        isCloseWhenTap: isCloseWhenTap,
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _renderDefaultButton({
  required BuildContext context,
  required BetterDialogTheme dialogTheme,
  bool showConfirmButton = true,
  bool showCancelButton = false,
  String confirmButtonText = "确认",
  Color? confirmButtonColor,
  bool confirmButtonDisabled = false,
  String cancelButtonText = "取消",
  Color? cancelButtonColor,
  bool cancelButtonDisabled = false,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  bool isCloseWhenTap = true,
}) {
  final bgColor = dialogTheme.bgColor ?? Colors.white;
  return Container(
    height: 48.bw,
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(color: ColorUtil.hexToColor("#ebedf0"), width: 1.bw),
      ),
    ),
    child: Row(
      children: [
        if (showCancelButton)
          Expanded(
            child: BetterButton(
              text: cancelButtonText,
              disabled: cancelButtonDisabled,
              onTap: () {
                if (isCloseWhenTap) {
                  Navigator.of(context).pop();
                }
                if (onCancel != null) onCancel();
              },
              textStyle: TextStyle(
                fontSize: 16.bsp,
                color:
                    cancelButtonColor ??
                    dialogTheme.cancelButtonColor ??
                    ColorUtil.hexToColor("#323232"),
              ),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
        if (showCancelButton && showConfirmButton)
          Container(
            width: 1.bw,
            height: double.infinity,
            color: ColorUtil.hexToColor("#ebedf0"),
          ),
        if (showConfirmButton)
          Expanded(
            child: BetterButton(
              text: confirmButtonText,
              disabled: confirmButtonDisabled,
              onTap: () {
                if (isCloseWhenTap) {
                  Navigator.of(context).pop();
                }
                if (onConfirm != null) onConfirm();
              },
              textStyle: TextStyle(
                fontSize: 16.bsp,
                color:
                    confirmButtonColor ??
                    dialogTheme.confirmButtonColor ??
                    Theme.of(context).primaryColor,
              ),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
      ],
    ),
  );
}
