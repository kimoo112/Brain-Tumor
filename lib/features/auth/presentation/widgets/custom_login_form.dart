import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/routes/navigation_functions.dart';
import '../../../../core/routes/routes.dart';
import '../widgets/custom_text_form_field.dart';

class CustomLoginForm extends StatefulWidget {
  const CustomLoginForm({
    super.key,
  });

  @override
  State<CustomLoginForm> createState() => _CustomLoginFormState();
}

class _CustomLoginFormState extends State<CustomLoginForm> {
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
        return Form(
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
                obscureText: authCubit.obscureConfirmPasswordTextValue,
                suffixIcon: IconButton(
                  onPressed: () {
                    authCubit.obscureConfirmPasswordText();
                  },
                  icon: authCubit.obscureConfirmPasswordTextValue == true
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
        );
      },
    );
  }
}
