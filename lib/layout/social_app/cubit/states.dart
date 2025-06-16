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
//___________________ Get All User Data For Chat_________________________________
class SocialGetAllUserDataLoadingStates extends SocialAppStates {}

class SocialGetAllUserDataSuccessStates extends SocialAppStates {}

class SocialGetAllUserDataErrorStates extends SocialAppStates {
  final String error;

  SocialGetAllUserDataErrorStates(this.error);
}
//___________________ Get Messages For Chat_________________________________

class SocialGetMessagesSuccessStates extends SocialAppStates {}
//___________________ Send Messages For Chat_________________________________
class SocialSendMessagesLoadingStates extends SocialAppStates {}

class SocialSendMessagesSuccessStates extends SocialAppStates {}

class SocialSendMessagesErrorStates extends SocialAppStates {
  final String error;

  SocialSendMessagesErrorStates(this.error);
}
//___________________ Get Posts Data_________________________________
class SocialGetPostsDataLoadingStates extends SocialAppStates {}

class SocialGetPostsDataSuccessStates extends SocialAppStates {}

class SocialGetPostsDataErrorStates extends SocialAppStates {
  final String error;

  SocialGetPostsDataErrorStates(this.error);
}
//___________________ password visibility__________________________________

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
} //____________________________CoverImage____________________________________________

class SocialCoverImagePickedSuccessState extends SocialAppStates {}

class SocialCoverImagePickedErrorState extends SocialAppStates {
  final String error;

  SocialCoverImagePickedErrorState(this.error);
}

//_____________________________Upload Image Profile___________________________________________
class UploadImageProfileLoadingState extends SocialAppStates {}

class UploadImageProfileSuccessState extends SocialAppStates {}

class UploadImageProfileErrorState extends SocialAppStates {
  final String error;

  UploadImageProfileErrorState(this.error);
}

//_____________________________Upload Cover Profile___________________________________________
class UploadCoverImageSuccessState extends SocialAppStates {}

class UploadCoverImageErrorState extends SocialAppStates {
  final String error;

  UploadCoverImageErrorState(this.error);
}
//____________________________Upload image post_______________________________

class UploadPostImageLoadingState extends SocialAppStates {}

class UploadPostImageSuccessState extends SocialAppStates {}

class UploadPostImageErrorState extends SocialAppStates {
  final String error;

  UploadPostImageErrorState(this.error);
}
class CreatePostLoadingState extends SocialAppStates {}

class CreatePostSuccessState extends SocialAppStates {}

class CreatePostErrorState extends SocialAppStates {
  final String error;

  CreatePostErrorState(this.error);
}

class LikePostSuccessState extends SocialAppStates {}
class CountLikePostSuccessState extends SocialAppStates {}

class LikePostErrorState extends SocialAppStates {
  final String error;

  LikePostErrorState(this.error);
}
class SocialPostImagePickedSuccessState extends SocialAppStates {}

class SocialPostImagePickedErrorState extends SocialAppStates {}

class RemovePostImageSuccessState extends SocialAppStates {}
