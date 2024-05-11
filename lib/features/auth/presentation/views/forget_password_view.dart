import 'package:brain_tumor/core/utils/app_assets.dart';
import 'package:brain_tumor/core/widgets/custom_button.dart';
import 'package:brain_tumor/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/navigation_functions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
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
          16.verticalSpace,
          Image.asset(Assets.imagesForgetPassword),
          32.verticalSpace,
          const CustomTextFormField(
            hintText: 'example@gmail.com',
            labelText: 'Email',
            isHavePrefix: false,
          ),
          64.verticalSpace,
          const CustomButton(
            text: 'Register',
            borderRadius: 12,
            marginSize: 0,
          ),
          16.verticalSpace,
          _rememberPassword(context)
        ],
      ),
    ));
  }

  Row _rememberPassword(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Remember Password ?',
          style: CustomTextStyles.poppins400Style16,
        ),
        TextButton(
          onPressed: () {
            customNavigate(context, loginView);
          },
          child: Text(
            'Login Now',
            style: CustomTextStyles.poppins400Style16
                .copyWith(color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}
