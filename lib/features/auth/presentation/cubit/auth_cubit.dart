import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/cache/cache_helper.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  String? firstName;
  String? secondName;
  String? emailAddress;
  String imagePath = '';
  ImagePicker picker = ImagePicker();

  String? password;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool? termsAndConditionCheckBoxValue = false;
  bool? obscurePasswordTextValue = true;
  bool? obscureConfirmPasswordTextValue = true;
  GlobalKey<FormState> signupFormKey = GlobalKey();
  GlobalKey<FormState> signInFormKey = GlobalKey();
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey();
  String? profileFirstName;
  String? profileLastName;
  Future<void> signUpWithEmailAndPassword() async {
    try {
      emit(SignupLoadingState());
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress!,
        password: password!,
      );
      await addUserProfile();
      await verifyEmail();
      emit(SignupSuccessState());
    } on FirebaseAuthException catch (e) {
      _signUpHandleException(e);
    } catch (e) {
      emit(SignupFailureState(errMessage: e.toString()));
    }
  }

  void _signUpHandleException(FirebaseAuthException e) {
    if (e.code == 'weak-password') {
      emit(
          SignupFailureState(errMessage: 'The password provided is too weak.'));
    } else if (e.code == 'email-already-in-use') {
      emit(SignupFailureState(
          errMessage: 'The account already exists for that email.'));
    } else if (e.code == 'invalid-email') {
      emit(SignupFailureState(errMessage: 'The email is invalid.'));
    } else {
      emit(SignupFailureState(errMessage: e.code));
    }
  }

  signOut() async {
    try {
      emit(SignOutLoading());
      await FirebaseAuth.instance.signOut();
      emit(SignOutSuccess());
    } catch (e) {
      emit(SignOutFailure());
    }
  }

  Future<void> verifyEmail() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

  void updateTermsAndConditionCheckBox({required newValue}) {
    termsAndConditionCheckBoxValue = newValue;
    emit(TermsAndConditionUpdateState());
  }

  void obscurePasswordText() {
    if (obscurePasswordTextValue == true) {
      obscurePasswordTextValue = false;
    } else {
      obscurePasswordTextValue = true;
    }
    emit(ObscurePasswordTextUpdateState());
  }

  void obscureConfirmPasswordText() {
    if (obscureConfirmPasswordTextValue == true) {
      obscureConfirmPasswordTextValue = false;
    } else {
      obscureConfirmPasswordTextValue = true;
    }
    emit(ObscureConfirmPasswordTextUpdateState());
  }

  Future<void> sigInWithEmailAndPassword() async {
    try {
      emit(SignInLoadingState());
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress!,
        password: password!,
      );
      emit(SignInSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(SignInFailureState(errMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(SignInFailureState(
            errMessage: 'Wrong password provided for that user.'));
      } else {
        emit(SignInFailureState(errMessage: 'Check your Email and password!'));
      }
    } catch (e) {
      emit(
        SignInFailureState(
          errMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> resetPasswordWithLink() async {
    try {
      emit(ResetPasswordLoadingState());
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailAddress!);
      emit(ResetPasswordSuccessState());
    } catch (e) {
      emit(ResetPasswordFailureState(errMessage: e.toString()));
    }
  }

  Future<void> addUserProfile() async {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    await users.add({
      "email": emailAddress,
      "first_name": firstName,
      "last_name": secondName,
    });
  }

  Future<void> fetchUserData() async {
    emit(UserLoading());
    try {
      profileFirstName = CacheHelper.getData(key: 'first_name');
      profileLastName = CacheHelper.getData(key: 'last_name');

      if (profileFirstName == null || profileLastName == null) {
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
          profileFirstName = userDoc['first_name'];
          profileLastName = userDoc['last_name'];
          CacheHelper.saveData(key: 'first_name', value: profileFirstName);
          CacheHelper.saveData(key: 'last_name', value: profileLastName);
        } else {
          throw Exception("User data not found");
        }
      }

      emit(UserLoaded(firstName: profileFirstName, lastName: profileLastName));
    } catch (e) {
      debugPrint('Error fetching user data: $e');
      emit(UserError('Error fetching user data'));
    }
  }

  Future<void> pickImageFromGallery() async {
    emit(ProfileImageEmpty());
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        imagePath = pickedFile.path;
        CacheHelper.saveData(
            key: "${FirebaseAuth.instance.currentUser!.uid} Image",
            value: imagePath);
        loadImage();
        emit(ProfileImagePicked(imagePath: imagePath));
      } else {}
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  loadImage() async {
    if (CacheHelper.getData(
            key: "${FirebaseAuth.instance.currentUser!.uid} Image") !=
        null) {
      imagePath = CacheHelper.getData(
          key: "${FirebaseAuth.instance.currentUser!.uid} Image")!;
      emit(ProfileImagePicked(imagePath: imagePath));
    } else {}
  }
}
