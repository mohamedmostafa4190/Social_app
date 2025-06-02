import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentos_app/componant/constant.dart';
import 'package:mentos_app/layout/social_app/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentos_app/models/social_app_model.dart';
import 'package:mentos_app/modules/social_app/chat_screen.dart';
import 'package:mentos_app/modules/social_app/home_screen.dart';
import 'package:mentos_app/modules/social_app/posts_screen.dart';
import 'package:mentos_app/modules/social_app/setting_screen.dart';
import 'package:mentos_app/modules/social_app/users_screen.dart';
import 'package:mentos_app/shared/local/cach_helper.dart';

class SocialAppCubit extends Cubit<SocialAppStates> {
  SocialAppCubit() : super(SocialAppInitialStates());

  static SocialAppCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility;
  int currentIndex = 0;
  SocialUserModel? userModel;
  File? profileImage;
  File? coverImage;
  final picker = ImagePicker();
  String? imageUrl = '';
  String? coverUrl = '';

  final List<Widget> screens = [
    HomeScreen(),
    ChatScreen(),
    PostsScreen(),
    UsersScreen(),
    SettingScreen(),
  ];
  final List<String> titles = ['Home', 'Chat', 'Posts', 'Users', 'Setting'];

  void changeBottom(int index) {
    if (index == 2) {
      emit(AddPostStates());
    } else {
      currentIndex = index;
      emit(AppChangeBottomNavBarStates());
    }
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ChangePasswordVisibilityStates());
  }

  void getUsersData() async {
    emit(SocialGetUserDataLoadingStates());
    await supabase
        .from('users')
        .select()
        .eq('id', id)
        .single()
        .then((value) {
          userModel = SocialUserModel.fromJson(value);
          print(value.toString());
          print('✅ بيانات المستخدم:');
          emit(SocialGetUserDataSuccessStates());
        })
        .catchError((error) {
          print('❌ Error getting user data: $error');
          emit(SocialGetUserDataErrorStates(error.toString()));
        });
  }

  void logOut() async {
    emit(LogOutLoadingStates());
    await supabase.auth
        .signOut()
        .then((value) async {
          print('تم تسجيل الخروج بنجاح');
          emit(LogOutSuccessStates());
          await CachHelper.removeData('uid');
        })
        .catchError((error) {
          emit(LogOutErrorStates(error.toString()));
        });
  }

  void updateUser({
    required String? name,
    required String? bio,
    String? userId,
    String? cover,
    String? image,
  }) async {
    SocialUserModel model = SocialUserModel(
      id: id,
      name: name,
      bio: bio,
      image: image ?? userModel!.image,
      profileCover: cover ?? userModel!.profileCover,
      phone: userModel!.phone,
      email: userModel!.email,
    );
    await supabase
        .from('users')
        .update(model.toJson())
        .eq('id', id)
        .then((value) {
          getUsersData();
          emit(UpdateUserDataSuccessStates());
          print('✅ تم تحديث البيانات بنجاح');
        })
        .catchError((error) {
          print('❌ خطأ في تحديث البيانات: $error');
          emit(UpdateUserDataErrorStates(error.toString()));
        });
  }
  Future<void> pickProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialProfileImagePickedErrorState('No Image Selected'));
    }
  }

  Future<void> pickCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialCoverImagePickedErrorState('No Image Selected'));
    }
  }

  Future<void> uploadProfileImage({
    required String? name,
    required String? bio,
  }) async {
    emit(UploadImageProfileLoadingState());
    if (profileImage == null) {
      emit(UploadImageProfileErrorState('❌ No profile image selected.'));
    }
    final fileName = Uri.file(profileImage!.path).pathSegments.last;
    imageUrl = supabase.storage.from('users').getPublicUrl(fileName);
    await supabase.storage
        .from('users')
        .upload(fileName, profileImage!)
        .then((value) {
          print(value);
          print('✅ File uploaded successfully: $imageUrl');
          emit(UploadImageProfileSuccessState());
          updateUser(name: name, bio: bio, image: imageUrl);
        })
        .catchError((error) {
          print('❌ Error uploading file: $error');
          emit(UploadImageProfileErrorState(error.toString()));
        });
  }

  Future<void> uploadCoverImage({
    required String? name,
    required String? bio,
  }) async {
    if (coverImage == null) {
      emit(UploadCoverImageErrorState('❌ No cover image selected.'));
    }
    final fileName = Uri.file(coverImage!.path).pathSegments.last;
    coverUrl = supabase.storage.from('users').getPublicUrl(fileName);
    await supabase.storage
        .from('users')
        .upload(fileName, coverImage!)
        .then((value) {
          print(value);
          print('✅ File uploaded successfully: $coverUrl');
          emit(UploadCoverImageSuccessState());
          updateUser(name: name, bio: bio, cover: coverUrl);
        })
        .catchError((error) {
          print('❌ Error uploading file: $error');
          emit(UploadCoverImageErrorState(error.toString()));
        });
  }
}
// void uploadFileToStorage() async {
//   firebase_storage.FirebaseStorage.instance
//       .ref()
//       .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
//       .putFile(profileImage!)
//       .then((value) {
//         print(value.toString());
//         value.ref.getDownloadURL().then((value) {
//           print(value.toString());
//         });
//       })
//       .catchError((error) {
//         print(error.toString('Error!!!!!'));
//       });
// }

// Test_______________________________________________________________________________
//   Future<void> makePayment({required String paymentIntentClientSecret}) async {
//     emit(PaymentLoading());
//
//     await Stripe.instance
//         .initPaymentSheet(
//           paymentSheetParameters: SetupPaymentSheetParameters(
//             paymentIntentClientSecret: paymentIntentClientSecret,
//             merchantDisplayName: 'Your App Name',
//           ),
//         )
//         .then((value) async {
//           await Stripe.instance.presentPaymentSheet();
//
//           emit(PaymentSuccess());
//         })
//         .catchError((error) {
//           emit(PaymentError(error: error.toString()));
//         });
//   }
// }
