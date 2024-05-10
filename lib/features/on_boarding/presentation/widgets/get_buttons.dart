import 'package:brain_tumor/core/routes/routes.dart';
import 'package:brain_tumor/core/utils/app_colors.dart';
import 'package:brain_tumor/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/routes/navigation_functions.dart';
import '../../../../core/utils/app_strings.dart';
import '../../data/models/on_boarding_model.dart';

class GetButtons extends StatelessWidget {
  const GetButtons(
      {super.key, required this.currentIndex, required this.controller});
  final int currentIndex;
  final PageController controller;
  @override
  Widget build(BuildContext context) {
    if (currentIndex == onBoardingData.length - 1) {
      return CustomButton(
        text: AppStrings.getStarted,
        textColor: AppColors.white,
        onPressed: () {
          customReplacementNavigate(context, loginView);
        },
      );
    } else {
      return Column(
        children: [
          CustomButton(
            text: AppStrings.next,
            textColor: AppColors.white,
            onPressed: () {
              controller.nextPage(
                duration: const Duration(milliseconds: 444),
                curve: Curves.fastLinearToSlowEaseIn,
              );
            },
          ),
        ],
      );
    }
  }
}
