import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/cache/cache_helper.dart';
import '../../../../core/routes/navigation_functions.dart';
import '../../../../core/routes/routes.dart';
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
      body: Center(
          child: SizedBox(
              width: 250.w,
              height: 250.h,
              child: Image.asset(Assets.imagesSloganText))),
    );
  }
}
