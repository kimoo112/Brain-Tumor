import '../../../../core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/navigation_functions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../widgets/custom_signup_form.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(12.0.sp),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            40.verticalSpace,
            _buildTitleText(),
            16.verticalSpace,
            _buildDescriptionText(),
            32.verticalSpace,
            const CustomSignUpForm(),
            12.verticalSpace,
            _alreadyHaveAccount(context)
          ],
        ),
      ),
    ));
  }

  Row _alreadyHaveAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: Text(
            'Already Have an account ? ',
            style: CustomTextStyles.poppins400Style16,
          ),
        ),
        Flexible(
          child: TextButton(
            onPressed: () {
              customNavigate(context, loginView);
            },
            child: Text(
              'Login',
              style: CustomTextStyles.poppins400Style16
                  .copyWith(color: AppColors.primaryColor),
            ),
          ),
        ),
      ],
    );
  }

  Text _buildDescriptionText() {
    return Text(
      'Enter your info to create account',
      style: CustomTextStyles.poppins400Style16
          .copyWith(color: AppColors.darkGrey),
      textAlign: TextAlign.center,
    );
  }

  Text _buildTitleText() {
    return Text('Sign Up',
        style: CustomTextStyles.poppins400Style24
            .copyWith(fontWeight: FontWeight.bold));
  }
}
