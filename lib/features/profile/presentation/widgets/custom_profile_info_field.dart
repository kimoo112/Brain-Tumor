import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class CustomProfileInfoField extends StatelessWidget {
  const CustomProfileInfoField({
    super.key,
    required this.info,
    required this.infoTitle,
  });

  final String? info;
  final String infoTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(infoTitle, style: CustomTextStyles.poppins400Style18),
        11.verticalSpace,
        Text(
          info!,
          style: CustomTextStyles.poppins400Style16
              .copyWith(color: AppColors.primaryBlue),
        ),
        const Divider(
          color: AppColors.primaryBlue,
          endIndent: 50,
        ),
      ],
    );
  }
}
