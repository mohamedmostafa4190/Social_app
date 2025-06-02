abstract class SocialAppStates {}

class SocialAppInitialStates extends SocialAppStates {}

//___________________Login_________________________________
class SocialAppLoginLoadingStates extends SocialAppStates {}

class SocialAppLoginSuccessStates extends SocialAppStates {
  final String uid;

  SocialAppLoginSuccessStates(this.uid);
}

class SocialAppLoginErrorStates extends SocialAppStates {
  final String error;

  SocialAppLoginErrorStates(this.error);
}

//___________________ Get User Data_________________________________
class SocialGetUserDataLoadingStates extends SocialAppStates {}

class SocialGetUserDataSuccessStates extends SocialAppStates {}

class SocialGetUserDataErrorStates extends SocialAppStates {
  final String error;

  SocialGetUserDataErrorStates(this.error);
}

class ChangePasswordVisibilityStates extends SocialAppStates {}

class AppChangeBottomNavBarStates extends SocialAppStates {}

class AddPostStates extends SocialAppStates {}

//____________________________LOGOUT____________________________________________

class LogOutLoadingStates extends SocialAppStates {}

class LogOutSuccessStates extends SocialAppStates {}

class LogOutErrorStates extends SocialAppStates {
  final String error;

  LogOutErrorStates(this.error);
}
//____________________________UpdateUserData____________________________________________

class UpdateUserDataLoadingStates extends SocialAppStates {}

class UpdateUserDataSuccessStates extends SocialAppStates {}

class UpdateUserDataErrorStates extends SocialAppStates {
  final String error;

  UpdateUserDataErrorStates(this.error);
}

//____________________________ProfileImage____________________________________________
class SocialProfileImagePickedSuccessState extends SocialAppStates {}

class SocialProfileImagePickedErrorState extends SocialAppStates {
  final String error;

  SocialProfileImagePickedErrorState(this.error);
}//____________________________CoverImage____________________________________________
class SocialCoverImagePickedSuccessState extends SocialAppStates {}

class SocialCoverImagePickedErrorState extends SocialAppStates {
  final String error;

  SocialCoverImagePickedErrorState(this.error);
}
//_________________________________________________________________________________________
// class SignInSuccessState extends SocialAppStates {}

class UploadImageProfileLoadingState extends SocialAppStates {}
class UploadImageProfileSuccessState extends SocialAppStates {}
class UploadImageProfileErrorState extends SocialAppStates {
  final String error;

  UploadImageProfileErrorState(this.error);
}
class UploadCoverImageSuccessState extends SocialAppStates {}
class UploadCoverImageErrorState extends SocialAppStates {
  final String error;

  UploadCoverImageErrorState(this.error);
}
//________________________________________________________________________
// class PaymentLoading extends SocialAppStates {}
//
// class PaymentSuccess extends SocialAppStates {}
//
// class PaymentError extends SocialAppStates {
//   final String? error;
//
//   PaymentError({this.error});
// }
