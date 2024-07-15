import 'package:go_router/go_router.dart';

import '../../features/box/pages/plus_minus_page.dart';
import '../../features/home/pages/home_page.dart';
import '../../features/splash/onboard_page.dart';
import '../../features/splash/splash_page.dart';

final routerConfig = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/onboard',
      builder: (context, state) => const OnboardPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/plusminus',
      builder: (context, state) => PlusMinusPage(
        plus: state.extra as bool,
      ),
    ),
  ],
);
