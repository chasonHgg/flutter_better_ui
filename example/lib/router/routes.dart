import 'package:example/pages/button_page.dart';
import 'package:example/pages/home.dart';
import 'package:get/get_navigation/get_navigation.dart';

final routes = [
  GetPage(name: "/", page: () => const Home()),
  GetPage(name: "/betterButton", page: () => const BetterButtonPage()),
];
