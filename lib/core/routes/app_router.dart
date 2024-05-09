import 'package:brain_tumor/core/routes/routes.dart';
import 'package:brain_tumor/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:go_router/go_router.dart';

import '../../features/splash/presentation/views/splash_view.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const SplashView()
  ),
   GoRoute(
    path: onboarding,
    builder: (context, state) => const OnBoardingView()
  ),
]);
