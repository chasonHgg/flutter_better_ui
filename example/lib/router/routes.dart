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
import 'package:example/pages/better_skeleton_page.dart';
import 'package:example/pages/better_slide_action_page.dart';
import 'package:example/pages/better_swipe_action_page.dart';
import 'package:example/pages/better_swiper_page.dart';
import 'package:example/pages/better_switch_page.dart';
import 'package:example/pages/better_time_picker_page.dart';
import 'package:example/pages/better_toast_page.dart';
import 'package:example/pages/home.dart';
import 'package:get/get_navigation/get_navigation.dart';

final routes = [
  GetPage(name: "/", page: () => const Home()),
  GetPage(name: "/betterButton", page: () => const BetterButtonPage()),
  GetPage(name: "/betterCell", page: () => const BetterCellPage()),
  GetPage(name: "/betterToast", page: () => const BetterToastPage()),
  GetPage(name: "/betterPopup", page: () => const BetterPopupPage()),
  GetPage(name: "/betterPicker", page: () => const BetterPickerPage()),
  GetPage(name: "/betterSwitch", page: () => const BetterSwitchPage()),
  GetPage(name: "/betterDatePicker", page: () => const BetterDatePickerPage()),
  GetPage(
    name: "/betterSwipeAction",
    page: () => const BetterSwipeActionPage(),
  ),
  GetPage(
    name: "/betterSlideAction",
    page: () => const BetterSlideActionPage(),
  ),
  GetPage(name: "/betterTimePicker", page: () => const BetterTimePickerPage()),
  GetPage(name: "/betterMarquee", page: () => const BetterMarqueePage()),
  GetPage(name: "/betterSwiper", page: () => const BetterSwiperPage()),
  GetPage(
    name: "/betterImagePreview",
    page: () => const BetterImagePreviewPage(),
  ),
  GetPage(name: "/betterIndexBar", page: () => const BetterIndexBarPage()),
  GetPage(name: "/betterCollapse", page: () => const BetterCollapsePage()),
  GetPage(name: "/betterDialog", page: () => const BetterDialogPage()),
  GetPage(name: "/betterSkeleton", page: () => const BetterSkeletonPage()),
];
