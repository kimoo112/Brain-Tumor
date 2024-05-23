import 'package:brain_tumor/core/routes/routes.dart';
import 'package:brain_tumor/features/auth/cubit/auth_cubit.dart';
import 'package:brain_tumor/features/auth/cubit/auth_state.dart';
import 'package:brain_tumor/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/navigation_functions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/terms_condition_widget.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  GlobalKey<FormState> signupFormKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignupSuccessState) {
          CherryToast.success(
              title: const Text(
                  'Successfully,Check your email to verify your account'));
          customReplacementNavigate(context, loginView);
        } else if (state is SignupFailureState) {
          CherryToast.error(title: Text(state.errMessage));
        }
      },
      builder: (context, state) {
        AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
        return Scaffold(
            body: Padding(
          padding: EdgeInsets.all(8.0.sp),
          child: Form(
            key: signupFormKey,
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
                      child: CustomTextFormField(
                        labelText: 'First Name',
                        hintText: 'Leonardo',
                        onChanged: (firstName) {
                          authCubit.firstName = firstName;
                        },
                        isHavePrefix: false,
                      ),
                    )),
                    Flexible(
                        child: Padding(
                      padding: EdgeInsets.only(left: 8.0.sp),
                      child: CustomTextFormField(
                        labelText: 'Second Name',
                        hintText: 'Dicaprio',
                        onChanged: (secondName) {
                          authCubit.secondName = secondName;
                        },
                        isHavePrefix: false,
                      ),
                    )),
                  ],
                ),
                16.verticalSpace,
                CustomTextFormField(
                  labelText: 'Email Address',
                  hintText: 'example@gmail.com',
                  isHavePrefix: false,
                  onChanged: (emailAddress) {
                    authCubit.emailAddress = emailAddress;
                  },
                ),
                24.verticalSpace,
                CustomTextFormField(
                  labelText: 'Password',
                  hintText: "************",
                  isHavePrefix: false,
                  onChanged: (password) {
                    authCubit.password = password;
                  },
                ),
                24.verticalSpace,
                const CustomTextFormField(
                  labelText: 'Confirm Password',
                  hintText: "************",
                  isHavePrefix: false,
                ),
                24.verticalSpace,
                const TermsConditionWidget(),
                24.verticalSpace,
                state is SignupLoadingState
                    ? const CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      )
                    : CustomButton(
                        text: 'SignUp'.toUpperCase(),
                        borderRadius: 12.r,
                        color: authCubit.termsAndConditionCheckBoxValue == false
                            ? AppColors.darkGrey
                            : null,
                        marginSize: 0,
                        textColor: AppColors.white,
                        onPressed: () async {
                          if (authCubit.termsAndConditionCheckBoxValue ==
                              true) {
                            if (signupFormKey.currentState!.validate()) {
                              await authCubit.signUpWithEmailAndPassword();
                            }
                          }
                        },
                      ),
                12.verticalSpace,
                _alreadyHaveAccount(context)
              ],
            ),
          ),
        ));
      },
    );
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
