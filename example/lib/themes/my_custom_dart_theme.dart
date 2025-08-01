import 'package:better_ui/theme/better_theme_extension.dart';
import 'package:better_ui/theme/themes/better_dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData myCustomDarkTheme = betterDarkTheme.copyWith(
  extensions: [
    betterDarkTheme.extension<BetterThemeExtension>()!.copyWith(
      cellTheme: betterDarkTheme
          .extension<BetterThemeExtension>()!
          .cellTheme
          .copyWith(
            height: 44.w,
            arrowRightSize: 14.sp,
            arrowRightMarginLeft: 4.sp,
            titleTextStyle: betterDarkTheme
                .extension<BetterThemeExtension>()!
                .cellTheme
                .titleTextStyle
                ?.copyWith(fontSize: 14.sp),
            valueTextStyle: betterDarkTheme
                .extension<BetterThemeExtension>()!
                .cellTheme
                .valueTextStyle
                ?.copyWith(fontSize: 14.sp),
          ),
    ),
  ],
);
