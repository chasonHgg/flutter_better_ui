import 'package:example/pages/button_page.dart';
import 'package:example/pages/home.dart';
import 'package:go_router/go_router.dart';

final goRoutes = GoRouter(
  routes: [
    GoRoute(path: "/", builder: (context, state) => const Home()),
    GoRoute(
      path: "/betterButton",
      builder: (context, state) => const BetterButtonPage(),
    ),
  ],
);
