
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class UserProfileInfo extends StatelessWidget {
  const UserProfileInfo({
    super.key,
    required this.firstName,
    required this.lastName,
  });

  final String? firstName;
  final String? lastName;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$firstName $lastName',
              style: CustomTextStyles.poppins400Style18),
          Text(
            'Online',
            style: CustomTextStyles.poppins400Style14
                .copyWith(color: AppColors.primaryBlue),
          ),
        ],
      );
  }
}
