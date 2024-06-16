import 'package:brain_tumor/core/routes/navigation_functions.dart';
import 'package:brain_tumor/core/routes/routes.dart';
import 'package:brain_tumor/core/utils/app_assets.dart';
import 'package:brain_tumor/core/utils/app_colors.dart';
import 'package:brain_tumor/core/utils/app_text_styles.dart';
import 'package:brain_tumor/core/widgets/custom_button.dart';
import 'package:brain_tumor/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:brain_tumor/features/auth/presentation/cubit/auth_state.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/custom_text_form_field.dart';
import '../widgets/social_media_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> signInFormKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignInSuccessState) {
          if (FirebaseAuth.instance.currentUser!.emailVerified) {
            customReplacementNavigate(context, appNavigation);
            CherryToast.success(
              title: const Text('Successfully signed in'),
              animationType: AnimationType.fromTop,
              animationDuration: const Duration(milliseconds: 700),
            ).show(context);
          } else {
            CherryToast.warning(
              title: const Text(
                "You should verify your account first",
                style: TextStyle(color: Colors.black),
              ),
              animationType: AnimationType.fromTop,
              animationDuration: const Duration(milliseconds: 700),
            ).show(context);
          }
        } else if (state is SignInFailureState) {
          CherryToast.error(
            title: Text(state.errMessage),
            animationType: AnimationType.fromTop,
            animationDuration: const Duration(milliseconds: 700),
          ).show(context);
        }
      },
      builder: (context, state) {
        AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: SingleChildScrollView(
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
                  Form(
                    key: signInFormKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          hintText: 'Email Address',
                          isHavePrefix: false,
                          onChanged: (emailAddress) {
                            authCubit.emailAddress = emailAddress;
                          },
                        ),
                        24.verticalSpace,
                        CustomTextFormField(
                          hintText: 'Password',
                          isHavePrefix: false,
                          obscureText:
                              authCubit.obscureConfirmPasswordTextValue,
                          suffixIcon: IconButton(
                            onPressed: () {
                              authCubit.obscureConfirmPasswordText();
                            },
                            icon: authCubit.obscureConfirmPasswordTextValue ==
                                    true
                                ? const FaIcon(FontAwesomeIcons.eye)
                                : const FaIcon(FontAwesomeIcons.eyeSlash),
                          ),
                          onChanged: (password) {
                            authCubit.password = password;
                          },
                        ),
                        16.verticalSpace,
                        state is SignInLoadingState
                            ? const CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              )
                            : CustomButton(
                                text: 'Login'.toUpperCase(),
                                borderRadius: 12.r,
                                marginSize: 0,
                                textColor: AppColors.white,
                                onPressed: () {
                                  if (signInFormKey.currentState!.validate()) {
                                    authCubit.sigInWithEmailAndPassword();
                                  }
                                },
                              ),
                      ],
                    ),
                  ),
                  16.verticalSpace,
                  TextButton(
                    onPressed: () {
                      customNavigate(context, forgetPasswordView);
                    },
                    child: Text(
                      'Forget Password ?',
                      style: CustomTextStyles.poppins400Style16
                          .copyWith(color: AppColors.primaryColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  16.verticalSpace,
                  _continueWith(),
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
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Row _continueWith() {
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
