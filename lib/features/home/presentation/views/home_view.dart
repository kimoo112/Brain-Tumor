import 'package:brain_tumor/core/utils/app_assets.dart';
import 'package:brain_tumor/core/utils/app_colors.dart';
import 'package:brain_tumor/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(Assets.imagesPlusDocument),
            12.verticalSpace,
            Text(
              'You don’t have any documents',
              style: CustomTextStyles.poppins400Style16,
            ),
            8.verticalSpace,
            Text(
              'Sync docs accross smartphones, tablets, and computers',
              style: CustomTextStyles.poppins400Style12
                  .copyWith(color: AppColors.darkGrey),
              textAlign: TextAlign.center,
            ),
            16.verticalSpace,

            Image.asset(Assets.imagesArrowDown)
          ],
        ),
      ),
    );
  }
}
