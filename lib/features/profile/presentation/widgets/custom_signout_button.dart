import '../../../../core/routes/routes.dart';
import '../../../auth/presentation/cubit/auth_state.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';

class CustomSignOutButton extends StatelessWidget {
  const CustomSignOutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignOutSuccess) {
          context.pushReplacement(loginView);
          CherryToast.info(
                  title: const Text('Signed Out, Wish to see you again soon! '))
              .show(context);
        }
      },
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context.read<AuthCubit>().signOut();
          },
          borderRadius: BorderRadius.circular(25.0.sp),
          splashColor: AppColors.primaryLightBlue.withOpacity(.3),
          child: state is SignOutLoading
              ? const CircularProgressIndicator(
                  color: AppColors.primaryLightBlue,
                )
              : Container(
                  width: double.infinity,
                  height: 60.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0.sp),
                      color: Colors.transparent,
                      border: Border.all(
                          color: AppColors.primaryBlue.withOpacity(.6),
                          width: 2)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sign out',
                          style: CustomTextStyles.poppins400Style14
                              .copyWith(
                                  color: AppColors.primaryLightBlue,
                                  fontWeight: FontWeight.w100),
                        ),
                        Image.asset(Assets.imagesSignoutIcon)
                      ],
                    ),
                  )),
        );
      },
    );
  }
}
