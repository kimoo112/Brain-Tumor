class AuthState {}

final class AuthInitial extends AuthState {}

final class SignupLoadingState extends AuthState {}

final class SignupSuccessState extends AuthState {}

final class SignupFailureState extends AuthState {
  final String errMessage;

  SignupFailureState({required this.errMessage});
}

final class SignInLoadingState extends AuthState {}

final class SignInSuccessState extends AuthState {}

final class SignInFailureState extends AuthState {
  final String errMessage;

  SignInFailureState({required this.errMessage});
}

final class ResetPasswordLoadingState extends AuthState {}

final class ResetPasswordSuccessState extends AuthState {}

final class ResetPasswordFailureState extends AuthState {
  final String errMessage;

  ResetPasswordFailureState({required this.errMessage});
}

final class TermsAndConditionUpdateState extends AuthState {}

final class ObscurePasswordTextUpdateState extends AuthState {}
final class ObscureConfirmPasswordTextUpdateState extends AuthState {}
final class SignOutLoading extends AuthState {}
final class SignOutSuccess extends AuthState {}
final class SignOutFailure extends AuthState {}
 class UserLoading extends AuthState {}

class UserLoaded extends AuthState {
  final String? firstName;
  final String? lastName;

  UserLoaded({required this.firstName, required this.lastName});
}

class UserError extends AuthState {
  final String message;

  UserError(this.message);
} 
final class ProfileImageEmpty extends AuthState {}
final class ProfileImageLoading extends AuthState {}

final class ProfileImagePicked extends AuthState {
  final String imagePath;

  ProfileImagePicked({required this.imagePath});
}
