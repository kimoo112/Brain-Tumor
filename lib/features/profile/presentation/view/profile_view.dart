import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../auth/presentation/cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../widgets/custom_profile_info_field.dart';
import '../widgets/custom_signout_button.dart';
import '../widgets/profile_picture_widget.dart';
import '../widgets/user_profile_info.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().loadImage();
    context.read<AuthCubit>().fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(24.0.sp),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _profileTopBar(),
                  16.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const ProfilePicture(),
                      8.horizontalSpace,
                      BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                        if (state is UserLoading) {
                          return const CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          );
                        } else if (state is UserLoaded) {
                          return UserProfileInfo(
                            firstName: state.firstName!,
                            lastName: state.lastName!,
                          );
                        } else if (state is UserError) {
                          return Text('Error: ${state.message}');
                        }
                        return Container();
                      })
                    ],
                  ),
                  22.verticalSpace,
                  CustomProfileInfoField(
                      infoTitle: "First Name",
                      info: context.read<AuthCubit>().profileFirstName),
                  22.verticalSpace,
                  CustomProfileInfoField(
                      infoTitle: "Last Name",
                      info: context.read<AuthCubit>().profileLastName),
                  22.verticalSpace,
                  CustomProfileInfoField(
                      infoTitle: "Email Address",
                      info: FirebaseAuth.instance.currentUser!.email!),
                  55.verticalSpace,
                  const CustomSignOutButton()
                ],
              ),
            ),
          ),
          Positioned(
              top: 0, right: 0, child: Image.asset(Assets.imagesBlueCircle)),
          Positioned(
              top: 0, right: 0, child: Image.asset(Assets.imagesPurpleCircle)),
        ],
      ),
    );
  }

  Text _profileTopBar() {
    return Text(
      'Profile',
      style: CustomTextStyles.poppins400Style24,
    );
  }
}
