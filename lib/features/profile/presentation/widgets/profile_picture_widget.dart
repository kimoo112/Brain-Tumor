import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/presentation/cubit/auth_state.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
                radius: 50.r,
                backgroundColor: Colors.transparent,
                backgroundImage: context.read<AuthCubit>().imagePath == ''
                    ? const AssetImage(Assets.imagesSlogan)
                    : FileImage(File(context.read<AuthCubit>().imagePath))
                        as ImageProvider),
            FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: AppColors.primaryColor,
              onPressed: () {
                context.read<AuthCubit>().pickImageFromGallery();
              },
              mini: true,
              child: const Icon(
                Icons.edit,
                color: AppColors.white,
              ),
            ),
          ],
        );
      },
    );
  }
}
