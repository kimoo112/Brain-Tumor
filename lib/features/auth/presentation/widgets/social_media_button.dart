import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

class SocialMediaButton extends StatelessWidget {
  const SocialMediaButton({
    super.key,
    required this.image, this.onTap,
  });
  final String image;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45.h,
        width: 75.w,
        margin: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  blurRadius: 11,
                  spreadRadius: 3,
                  color: AppColors.lightGrey.withOpacity(.8))
            ]),
        child: Image.asset(image),
      ),
    );
  }
}
