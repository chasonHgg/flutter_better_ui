import 'package:example/pages/better_button_page.dart';
import 'package:example/pages/better_cell_page.dart';
import 'package:example/pages/better_collapse_page.dart';
import 'package:example/pages/better_date_picker_page.dart';
import 'package:example/pages/better_dialog_page.dart';
import 'package:example/pages/better_index_bar_page.dart';
import 'package:example/pages/better_image_preview_page.dart';
import 'package:example/pages/better_marquee_page.dart';
import 'package:example/pages/better_picker_page.dart';
import 'package:example/pages/better_popup_page.dart';
import 'package:example/pages/better_popover_page.dart';
import 'package:example/pages/better_progress_page.dart';
import 'package:example/pages/better_skeleton_page.dart';
import 'package:example/pages/better_slider_page.dart';
import 'package:example/pages/better_slide_action_page.dart';
import 'package:example/pages/better_swipe_action_page.dart';
import 'package:example/pages/better_swiper_page.dart';
import 'package:example/pages/better_switch_page.dart';
import 'package:example/pages/better_time_picker_page.dart';
import 'package:example/pages/better_toast_page.dart';
import 'package:example/pages/home.dart';
import 'package:flutter_better_ui/better_ui.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  navigatorKey: BetterUi.navigatorKey,
  routes: [
    GoRoute(path: '/', builder: (context, state) => const Home()),
    GoRoute(
      path: '/betterButton',
      builder: (context, state) => const BetterButtonPage(),
    ),
    GoRoute(
      path: '/betterCell',
      builder: (context, state) => const BetterCellPage(),
    ),
    GoRoute(
      path: '/betterToast',
      builder: (context, state) => const BetterToastPage(),
    ),
    GoRoute(
      path: '/betterPopup',
      builder: (context, state) => const BetterPopupPage(),
    ),
    GoRoute(
      path: '/betterPopover',
      builder: (context, state) => const BetterPopoverPage(),
    ),
    GoRoute(
      path: '/betterProgress',
      builder: (context, state) => const BetterProgressPage(),
    ),
    GoRoute(
      path: '/betterSlider',
      builder: (context, state) => const BetterSliderPage(),
    ),
    GoRoute(
      path: '/betterPicker',
      builder: (context, state) => const BetterPickerPage(),
    ),
    GoRoute(
      path: '/betterSwitch',
      builder: (context, state) => const BetterSwitchPage(),
    ),
    GoRoute(
      path: '/betterDatePicker',
      builder: (context, state) => const BetterDatePickerPage(),
    ),
    GoRoute(
      path: '/betterSwipeAction',
      builder: (context, state) => const BetterSwipeActionPage(),
    ),
    GoRoute(
      path: '/betterSlideAction',
      builder: (context, state) => const BetterSlideActionPage(),
    ),
    GoRoute(
      path: '/betterTimePicker',
      builder: (context, state) => const BetterTimePickerPage(),
    ),
    GoRoute(
      path: '/betterMarquee',
      builder: (context, state) => const BetterMarqueePage(),
    ),
    GoRoute(
      path: '/betterSwiper',
      builder: (context, state) => const BetterSwiperPage(),
    ),
    GoRoute(
      path: '/betterImagePreview',
      builder: (context, state) => const BetterImagePreviewPage(),
    ),
    GoRoute(
      path: '/betterIndexBar',
      builder: (context, state) => const BetterIndexBarPage(),
    ),
    GoRoute(
      path: '/betterCollapse',
      builder: (context, state) => const BetterCollapsePage(),
    ),
    GoRoute(
      path: '/betterDialog',
      builder: (context, state) => const BetterDialogPage(),
    ),
    GoRoute(
      path: '/betterSkeleton',
      builder: (context, state) => const BetterSkeletonPage(),
    ),
  ],
);
