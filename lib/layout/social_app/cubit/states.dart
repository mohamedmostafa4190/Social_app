abstract class SocialAppStates {}

class SocialAppInitialStates extends SocialAppStates {}

class SocialAppRegisterLoadingStates extends SocialAppStates {}

class SocialAppRegisterSuccessStates extends SocialAppStates {}

class SocialAppRegisterErrorStates extends SocialAppStates {
  final String error;

  SocialAppRegisterErrorStates(this.error);
}

class SocialAppLoginLoadingStates extends SocialAppStates {}

class SocialAppLoginSuccessStates extends SocialAppStates {
  final String uid;

  SocialAppLoginSuccessStates(this.uid);
}

class SocialAppLoginErrorStates extends SocialAppStates {
  final String error;

  SocialAppLoginErrorStates(this.error);
}

class SocialCreateUserSuccessStates extends SocialAppStates {
  final String uid;

  SocialCreateUserSuccessStates(this.uid);

}

class SocialCreateUserErrorStates extends SocialAppStates {
  final String error;

  SocialCreateUserErrorStates(this.error);
}

class ChangePasswordVisibilityStates extends SocialAppStates {}

class AppChangeBottomNavBarStates extends SocialAppStates {}

//________________________________________________________________________
class PaymentLoading extends SocialAppStates {}

class PaymentSuccess extends SocialAppStates {}

class PaymentError extends SocialAppStates {
  final String? error;

  PaymentError({this.error});
}
