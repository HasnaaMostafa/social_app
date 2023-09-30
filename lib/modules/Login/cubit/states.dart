abstract class SocialLoginStates {}

class SocialLoginInitialStates extends SocialLoginStates {}

class SocialLoginLoadingStates extends SocialLoginStates {}

class SocialLoginSuccessStates extends SocialLoginStates {
  final String uId;
  SocialLoginSuccessStates(this.uId);
}

class SocialLoginErrorStates extends SocialLoginStates {
  final String error;
  SocialLoginErrorStates(this.error);
}

class SocialChangePasswordVisibilityStates extends SocialLoginStates {}

class LogoutLoadingState extends SocialLoginStates {}

class LogoutSuccessState extends SocialLoginStates {}

class LogoutErrorState extends SocialLoginStates {
  final String error;
  LogoutErrorState({required this.error});
}
