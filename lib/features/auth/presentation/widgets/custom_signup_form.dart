import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'custom_text_form_field.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/cache/cache_helper.dart';
import '../../../../core/routes/navigation_functions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/terms_condition_widget.dart';

class CustomSignUpForm extends StatefulWidget {
  const CustomSignUpForm({
    super.key,
  });

  @override
  State<CustomSignUpForm> createState() => _CustomSignUpFormState();
}

class _CustomSignUpFormState extends State<CustomSignUpForm> {
  GlobalKey<FormState> signupFormKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignupSuccessState) {
          BlocProvider.of<AuthCubit>(context).confirmPasswordController.clear();
          BlocProvider.of<AuthCubit>(context).passwordController.clear();
          CherryToast.success(
            title: const Text(
                'Successfully,Check your email to verify your account'),
            animationType: AnimationType.fromTop,
            animationDuration: const Duration(milliseconds: 700),
          ).show(context);
          customReplacementNavigate(context, loginView);
          CacheHelper.removeData(key: AppStrings.terms);
        } else if (state is SignupFailureState) {
          CherryToast.error(
            title: Text(state.errMessage),
            animationType: AnimationType.fromTop,
            animationDuration: const Duration(milliseconds: 700),
          ).show(context);
        }
      },
      builder: (context, state) {
        AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
        return Form(
          key: signupFormKey,
          child: Column(
            children: [
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
                controller: authCubit.passwordController,
                hintText: "************",
                obscureText: authCubit.obscurePasswordTextValue,
                suffixIcon: IconButton(
                  onPressed: () {
                    authCubit.obscurePasswordText();
                  },
                  icon: authCubit.obscurePasswordTextValue == true
                      ? const FaIcon(FontAwesomeIcons.eye)
                      : const FaIcon(FontAwesomeIcons.eyeSlash),
                ),
                isHavePrefix: false,
                onChanged: (password) {
                  authCubit.password = password;
                },
              ),
              24.verticalSpace,
              CustomTextFormField(
                labelText: 'Confirm Password',
                hintText: "************",
                controller: authCubit.confirmPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Confirm Your Password';
                  }
                  if (authCubit.confirmPasswordController.text !=
                      authCubit.passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                isHavePrefix: false,
                obscureText: authCubit.obscureConfirmPasswordTextValue,
                suffixIcon: IconButton(
                  onPressed: () {
                    authCubit.obscureConfirmPasswordText();
                  },
                  icon: authCubit.obscureConfirmPasswordTextValue == true
                      ? const FaIcon(FontAwesomeIcons.eye)
                      : const FaIcon(FontAwesomeIcons.eyeSlash),
                ),
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
                        if (authCubit.termsAndConditionCheckBoxValue == true) {
                          if (signupFormKey.currentState!.validate()) {
                            await authCubit.signUpWithEmailAndPassword();
                          }
                        }
                      },
                    ),
            ],
          ),
        );
      },
    );
  }
}
