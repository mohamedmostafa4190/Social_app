abstract class SocialAppLoginStates {}

class SocialAppLoginInitialStates extends SocialAppLoginStates {}

//___________________Login_________________________________
class SocialAppLoginLoadingStates extends SocialAppLoginStates {}

class SocialAppLoginSuccessStates extends SocialAppLoginStates {
  final String id;

  SocialAppLoginSuccessStates(this.id);
}

class SocialAppLoginErrorStates extends SocialAppLoginStates {
  final String error;

  SocialAppLoginErrorStates(this.error);
}

class ChangePasswordVisibilityStates extends SocialAppLoginStates {}




class SocialGetUserDataLoadingStates extends SocialAppLoginStates {}

class SocialGetUserDataSuccessStates extends SocialAppLoginStates {}

class SocialGetUserDataErrorStates extends SocialAppLoginStates {
  final String error;

  SocialGetUserDataErrorStates(this.error);
}