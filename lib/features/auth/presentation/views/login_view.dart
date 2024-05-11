import 'package:brain_tumor/core/routes/navigation_functions.dart';
import 'package:brain_tumor/core/routes/routes.dart';
import 'package:brain_tumor/core/utils/app_assets.dart';
import 'package:brain_tumor/core/utils/app_colors.dart';
import 'package:brain_tumor/core/utils/app_text_styles.dart';
import 'package:brain_tumor/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_text_form_field.dart';
import '../widgets/social_media_button.dart';

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
              text: 'Login'.toUpperCase(),
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
            Row(
              children: [
                 Expanded(
                  child: Divider(
                    indent: 10,
                  endIndent: 10,                          color: AppColors.darkGrey.withOpacity(.6),

                    thickness: .7, 
                  ),
                ),
                Expanded(
                  child: Text(
                    'Or Continue With',
                    style: CustomTextStyles.poppins400Style16.copyWith(
                        color: AppColors.primaryColor.withOpacity(.6),
                        fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
                
                 Expanded(
                  
                  child: Divider(
                  indent: 10,
                  endIndent: 10,
                                       color: AppColors.darkGrey.withOpacity(.6),
// Adjust color as needed
                    thickness: .7, // Adjust thickness as needed
                  ),
                ),
              ],
            ),
            8.verticalSpace,
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialMediaButton(
                  image: Assets.imagesGoogleIcon,
                ),
                SocialMediaButton(
                  image: Assets.imagesFacebookLogo,
                ),
              ],
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
                  onPressed: () {
                    customNavigate(context, signUpView);
                  },
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
