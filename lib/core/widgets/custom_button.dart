import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.color,
    required this.text,
    this.onPressed,
    this.marginSize,
    this.textColor,
    this.borderRadius,
  });

  final Color? color;
  final String text;
  final Color? textColor;
  final VoidCallback? onPressed;
  final double? marginSize;
  final double? borderRadius;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(borderRadius ?? 55.r),
      child: Container(
        margin: EdgeInsets.all(marginSize ?? 8),
        width: double.infinity,
        height: 56.h,
        decoration: BoxDecoration(
          color: color ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 55.r),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: CustomTextStyles.poppins400Style16.copyWith(
            color: textColor ?? AppColors.white
          )
        ),
      ),
    );
  }
}
