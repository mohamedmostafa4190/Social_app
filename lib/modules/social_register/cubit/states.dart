abstract class SocialAppRegisterStates {}

class SocialAppRegisterInitialStates extends SocialAppRegisterStates {}

//___________________ Register_________________________________
class SocialAppRegisterLoadingStates extends SocialAppRegisterStates {}

class SocialAppRegisterSuccessStates extends SocialAppRegisterStates {}

class SocialAppRegisterErrorStates extends SocialAppRegisterStates {
  final String error;

  SocialAppRegisterErrorStates(this.error);
}
//___________________ Create Users_________________________________
class SocialCreateUserSuccessStates extends SocialAppRegisterStates {
  final String uid;

  SocialCreateUserSuccessStates(this.uid);
}

class SocialCreateUserErrorStates extends SocialAppRegisterStates {
  final String error;

  SocialCreateUserErrorStates(this.error);
}

class ChangePasswordVisibilityStates extends SocialAppRegisterStates {}