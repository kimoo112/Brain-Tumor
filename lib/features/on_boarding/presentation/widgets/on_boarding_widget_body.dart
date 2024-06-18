import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../data/models/on_boarding_model.dart';
import 'custom_smooth_page_indicator.dart';

class OnBoardingWidgetBody extends StatelessWidget {
  const OnBoardingWidgetBody(
      {super.key, required this.controller, this.onPageChanged});
  final PageController controller;
  final Function(int)? onPageChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 650.h,
      child: PageView.builder(
        onPageChanged: onPageChanged,
        physics: const BouncingScrollPhysics(),
        controller: controller,
        itemCount: onBoardingData.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 350.h,
                width: 343.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      onBoardingData[index].imagePath,
                    ),
                  ),
                ),
              ),
              40.verticalSpace,
              Text(
                onBoardingData[index].title,
                style: CustomTextStyles.poppins400Style24.copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              12.verticalSpace,
              Text(
                onBoardingData[index].subTitle,
                style: CustomTextStyles.poppins400Style16,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              40.verticalSpace,
              CustomSmoothPageIndicator(controller: controller),
            ],
          );
        },
      ),
    );
  }
}
