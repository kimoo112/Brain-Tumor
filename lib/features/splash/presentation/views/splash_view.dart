import '../../../../core/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/cache/cache_helper.dart';
import '../../../../core/routes/navigation_functions.dart';
import '../../../../core/utils/app_assets.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    bool isOnBoardingVisited =
        CacheHelper.getData(key: "isOnBoardingVisited") ?? false;
    if (isOnBoardingVisited == true) {
      FirebaseAuth.instance.currentUser == null
          ? delayedNavigate(context, loginView)
          : FirebaseAuth.instance.currentUser!.emailVerified == true
              ? delayedNavigate(context, appNavigation)
              : delayedNavigate(context, loginView);
    } else {
      delayedNavigate(context, onboarding);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(Assets.imagesLogo)),
    );
  }
}
