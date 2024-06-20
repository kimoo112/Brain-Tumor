import '../../../../core/utils/app_assets.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/navigation_functions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> forgetPasswordKey = GlobalKey();
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(12.0),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
          return Form(
            key: forgetPasswordKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Forget Password',
                    style: CustomTextStyles.poppins400Style24
                        .copyWith(fontWeight: FontWeight.bold)),
                16.verticalSpace,
                Text(
                  'Don‘t Worry! It occurs. please enter the email address linked with your account',
                  style: CustomTextStyles.poppins400Style16
                      .copyWith(color: AppColors.darkGrey),
                  textAlign: TextAlign.center,
                ),
                24.verticalSpace,
                Image.asset(Assets.imagesForgetPassword),
                32.verticalSpace,
                CustomTextFormField(
                  onChanged: (emailAddress) {
                    authCubit.emailAddress = emailAddress;
                  },
                  hintText: 'example@gmail.com',
                  labelText: 'Email',
                  isHavePrefix: false,
                ),
                32.verticalSpace,
                CustomButton(
                  text: 'Register',
                  borderRadius: 12,
                  marginSize: 0,
                  onPressed: () async {
                    if (forgetPasswordKey.currentState!.validate()) {
                      await authCubit.resetPasswordWithLink();
                    }
                  },
                ),
                16.verticalSpace,
                _rememberPassword(context)
              ],
            ),
          );
        },
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
