import 'package:brain_tumor/core/utils/app_assets.dart';
import 'package:brain_tumor/core/utils/app_colors.dart';
import 'package:brain_tumor/core/utils/app_text_styles.dart';
import 'package:brain_tumor/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_text_form_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login',
                style: CustomTextStyles.poppins400Style24
                    .copyWith(fontWeight: FontWeight.bold)),
            16.verticalSpace,
            Text(
              'Enter your credentials to access your account',
              style: CustomTextStyles.poppins400Style16
                  .copyWith(color: AppColors.darkGrey),
              textAlign: TextAlign.center,
            ),
            32.verticalSpace,
            const CustomTextFormField(
              hintText: 'Email Address',
              isHavePrefix: false,
            ),
            24.verticalSpace,
            const CustomTextFormField(
              hintText: 'Password',
              isHavePrefix: false,
            ),
            16.verticalSpace,
            CustomButton(
              text: 'Login',
              borderRadius: 12.r,
              marginSize: 0,
              textColor: AppColors.white,
              onPressed: () {},
            ),
            16.verticalSpace,
            Text(
              'Forget Password ?',
              style: CustomTextStyles.poppins400Style16,
              textAlign: TextAlign.center,
            ),
            16.verticalSpace,
            Text(
              'Or Continue With',
              style: CustomTextStyles.poppins400Style16.copyWith(
                  color: AppColors.darkGrey.withOpacity(.6), fontSize: 12),
              textAlign: TextAlign.center,
            ),
            8.verticalSpace,
            Container(
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
              child: Image.asset(Assets.imagesGoogleIcon),
            ),
            16.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Don\'t have an account ? ',
                  style: CustomTextStyles.poppins400Style16,
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Sign Up',
                    style: CustomTextStyles.poppins400Style16
                        .copyWith(color: AppColors.primaryColor),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
