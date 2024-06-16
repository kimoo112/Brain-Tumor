import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import 'custom_check_box.dart';

class TermsConditionWidget extends StatelessWidget {
  const TermsConditionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomCheckBox(),
        Flexible(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: 'I Have Agree',
                    style: CustomTextStyles.poppins400Style14),
                TextSpan(
                    text: ' With Terms & Condition',
                    style: CustomTextStyles.poppins400Style14
                        .copyWith(color: AppColors.primaryColor)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
