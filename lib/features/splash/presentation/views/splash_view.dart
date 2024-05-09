import 'package:brain_tumor/core/routes/routes.dart';
import 'package:flutter/material.dart';

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
    super.initState();
    delayedNavigate(context, onboarding);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(Assets.imagesLogo)),
    );
  }
}
