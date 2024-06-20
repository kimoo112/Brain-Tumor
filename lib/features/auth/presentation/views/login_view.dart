import '../../../../core/routes/navigation_functions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/continue_with_social_media_buttons.dart';
import '../widgets/custom_login_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0.sp),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              40.verticalSpace,
              _buildLoginTitle(),
              16.verticalSpace,
              _buildLoginDescription(),
              32.verticalSpace,
              const CustomLoginForm(),
              16.verticalSpace,
              _buildForgetPasswordWidget(context),
              16.verticalSpace,
              _buildContinueWithWidget(),
              8.verticalSpace,
              const ContinueWithSocialMediaButtons(),
              16.verticalSpace,
              _buildDontHaveAccount(context)
            ],
          ),
        ),
      ),
    );
  }

  Text _buildLoginDescription() {
    return Text(
      'Enter your credentials to access your account',
      style: CustomTextStyles.poppins400Style16
          .copyWith(color: AppColors.darkGrey),
      textAlign: TextAlign.center,
    );
  }

  Text _buildLoginTitle() {
    return Text('Login',
        style: CustomTextStyles.poppins400Style24
            .copyWith(fontWeight: FontWeight.bold));
  }

  TextButton _buildForgetPasswordWidget(BuildContext context) {
    return TextButton(
      onPressed: () {
        customNavigate(context, forgetPasswordView);
      },
      child: Text(
        'Forget Password ?',
        style: CustomTextStyles.poppins400Style16
            .copyWith(color: AppColors.primaryColor),
        textAlign: TextAlign.center,
      ),
    );
  }

  Row _buildDontHaveAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: Text(
            'Don\'t have an account ? ',
            style: CustomTextStyles.poppins400Style16,
          ),
        ),
        Flexible(
          child: TextButton(
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
        ),
      ],
    );
  }

  Row _buildContinueWithWidget() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            indent: 10,
            endIndent: 10,
            color: AppColors.darkGrey.withOpacity(.6),
            thickness: .7,
          ),
        ),
        Expanded(
          child: Text(
            'Or Continue With',
            style: CustomTextStyles.poppins400Style16.copyWith(
                color: AppColors.primaryColor.withOpacity(.6), fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Divider(
            indent: 10,
            endIndent: 10,
            color: AppColors.darkGrey.withOpacity(.6),
            thickness: .7,
          ),
        ),
      ],
    );
  }
}
