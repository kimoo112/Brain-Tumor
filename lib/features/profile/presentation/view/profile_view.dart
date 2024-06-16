import 'package:brain_tumor/core/cache/cache_helper.dart';
import 'package:brain_tumor/core/utils/app_assets.dart';
import 'package:brain_tumor/core/utils/app_colors.dart';
import 'package:brain_tumor/core/utils/app_text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../widgets/custom_signout_button.dart';
import '../widgets/profile_picture_widget.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String? firstName;
  String? lastName;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().loadImage();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      firstName = CacheHelper.getData(key: 'first_name');
      lastName = CacheHelper.getData(key: 'last_name');

      if (firstName == null || lastName == null) {
        String? email = FirebaseAuth.instance.currentUser?.email;

        if (email == null) {
          throw Exception("No authenticated user found");
        }

        CollectionReference users =
            FirebaseFirestore.instance.collection('users');
        QuerySnapshot querySnapshot =
            await users.where('email', isEqualTo: email).get();

        if (querySnapshot.docs.isNotEmpty) {
          var userDoc = querySnapshot.docs.first;
          setState(() {
            firstName = userDoc['first_name'];
            lastName = userDoc['last_name'];
            CacheHelper.saveData(key: 'first_name', value: firstName);
            CacheHelper.saveData(key: 'last_name', value: lastName);
          });
        } else {
          throw Exception("User data not found");
        }
      }
    } catch (e) {
      debugPrint('Error fetching user data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
                  Text(
                    'Profile',
                    style: CustomTextStyles.poppins400Style24,
                  ),
                  16.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const ProfilePicture(),
                      8.horizontalSpace,
                      isLoading
                          ? const CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('$firstName $lastName',
                                    style: CustomTextStyles.poppins400Style18),
                                Text(
                                  'Online',
                                  style: CustomTextStyles.poppins400Style14
                                      .copyWith(color: AppColors.primaryBlue),
                                ),
                              ],
                            ),
                    ],
                  ),
                  22.verticalSpace,
                  Text('First Name', style: CustomTextStyles.poppins400Style18),
                  11.verticalSpace,
                  Text(
                    firstName!,
                    style: CustomTextStyles.poppins400Style16
                        .copyWith(color: AppColors.primaryBlue),
                  ),
                  const Divider(
                    color: AppColors.primaryBlue,
                    endIndent: 50,
                  ),
                  22.verticalSpace,
                  Text('Last Name', style: CustomTextStyles.poppins400Style18),
                  11.verticalSpace,
                  Text(
                    lastName!,
                    style: CustomTextStyles.poppins400Style16
                        .copyWith(color: AppColors.primaryBlue),
                  ),
                  const Divider(
                    color: AppColors.primaryBlue,
                    endIndent: 50,
                  ),
                  22.verticalSpace,
                  Text('Email Address',
                      style: CustomTextStyles.poppins400Style18),
                  11.verticalSpace,
                  Text(
                    FirebaseAuth.instance.currentUser!.email!,
                    style: CustomTextStyles.poppins400Style16
                        .copyWith(color: AppColors.primaryBlue),
                  ),
                  const Divider(
                    color: AppColors.primaryBlue,
                    endIndent: 50,
                  ),
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
}
