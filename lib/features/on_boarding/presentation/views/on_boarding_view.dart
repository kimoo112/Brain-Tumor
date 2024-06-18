import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/get_buttons.dart';
import '../widgets/on_boarding_widget_body.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _controller = PageController(initialPage: 0);
  int currentIndex = 0;
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            40.verticalSpace,
            OnBoardingWidgetBody(
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              controller: _controller,
            ),
            GetButtons(currentIndex: currentIndex, controller: _controller),
          ],
        ),
      ),
    );
  }
}
