
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class EmptyDocumentsWidget extends StatelessWidget {
  const EmptyDocumentsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.asset(Assets.imagesPlusDocument),
          12.verticalSpace,
          Text(
            'You don’t have any documents',
            style: CustomTextStyles.poppins400Style16,
          ),
          8.verticalSpace,
          Text(
            'Sync docs across smartphones, tablets, and computers',
            style: CustomTextStyles.poppins400Style12
                .copyWith(color: AppColors.darkGrey),
            textAlign: TextAlign.center,
          ),
          16.verticalSpace,
          Image.asset(Assets.imagesArrowDown),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
