import 'package:brain_tumor/core/routes/routes.dart';
import 'package:brain_tumor/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/navigation_functions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/terms_condition_widget.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTitleText(),
          16.verticalSpace,
          _buildDescriptionText(),
          32.verticalSpace,
          Row(
            children: [
              Flexible(
                  child: Padding(
                padding: EdgeInsets.only(right: 8.0.sp),
                child: const CustomTextFormField(
                  hintText: 'First Name',
                  isHavePrefix: false,
                ),
              )),
              Flexible(
                  child: Padding(
                padding: EdgeInsets.only(left: 8.0.sp),
                child: const CustomTextFormField(
                  hintText: 'Second Name',
                  isHavePrefix: false,
                ),
              )),
            ],
          ),
          16.verticalSpace,
          const CustomTextFormField(
            hintText: 'Email Address',
            isHavePrefix: false,
          ),
          24.verticalSpace,
          const CustomTextFormField(
            hintText: 'Password',
            isHavePrefix: false,
          ),
          24.verticalSpace,
          const CustomTextFormField(
            hintText: 'Confirm Password',
            isHavePrefix: false,
          ),
          24.verticalSpace,
          const TermsConditionWidget(),
          24.verticalSpace,
          CustomButton(
            text: 'SignUp'.toUpperCase(),
            borderRadius: 12.r,
            marginSize: 0,
            textColor: AppColors.white,
            onPressed: () {},
          ),
          _alreadyHaveAccount(context)
        ],
      ),
    ));
  }

  Row _alreadyHaveAccount(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already Have an account ? ',
              style: CustomTextStyles.poppins400Style16,
            ),
            TextButton(
              onPressed: () {
                customNavigate(context, loginView);
              },
              child: Text(
                'Login',
                style: CustomTextStyles.poppins400Style16
                    .copyWith(color: AppColors.primaryColor),
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
