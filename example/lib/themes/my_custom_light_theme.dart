import 'package:better_ui/theme/better_theme_extension.dart';
import 'package:better_ui/theme/themes/better_light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData myCustomLightTheme = betterLightTheme.copyWith(
  extensions: [
    betterLightTheme.extension<BetterThemeExtension>()!.copyWith(
      cellTheme: betterLightTheme
          .extension<BetterThemeExtension>()!
          .cellTheme
          .copyWith(
            height: 44.w,
            arrowRightSize: 14.sp,
            arrowRightMarginLeft: 4.sp,
            titleTextStyle: betterLightTheme
                .extension<BetterThemeExtension>()!
                .cellTheme
                .titleTextStyle
                ?.copyWith(fontSize: 14.sp),
            valueTextStyle: betterLightTheme
                .extension<BetterThemeExtension>()!
                .cellTheme
                .valueTextStyle
                ?.copyWith(fontSize: 14.sp),
          ),
    ),
  ],
);
