
abstract class SocialRegisterStates {}

class SocialRegisterInitialStates extends SocialRegisterStates {}

class SocialRegisterLoadingStates extends SocialRegisterStates {}

class SocialRegisterSuccessStates extends SocialRegisterStates {}

class SocialRegisterErrorStates extends SocialRegisterStates {
  final String error;
  SocialRegisterErrorStates(this.error) ;
}

class SocialUserCreatedSuccessStates extends SocialRegisterStates {}

class SocialUserCreatedErrorStates extends SocialRegisterStates {
  final String error;
  SocialUserCreatedErrorStates(this.error);
}

class SocialRegisterChangePasswordVisibilityStates extends SocialRegisterStates {}
