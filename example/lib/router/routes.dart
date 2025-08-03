import 'package:example/pages/better_button_page.dart';
import 'package:example/pages/better_cell_page.dart';
import 'package:example/pages/better_popup_page.dart';
import 'package:example/pages/better_toast_page.dart';
import 'package:example/pages/home.dart';
import 'package:get/get_navigation/get_navigation.dart';

final routes = [
  GetPage(name: "/", page: () => const Home()),
  GetPage(name: "/betterButton", page: () => const BetterButtonPage()),
  GetPage(name: "/betterCell", page: () => const BetterCellPage()),
  GetPage(name: "/betterToast", page: () => const BetterToastPage()),
  GetPage(name: "/betterPopup", page: () => const BetterPopupPage()),
];
