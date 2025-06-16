import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentos_app/componant/constant.dart';
import 'package:mentos_app/layout/social_app/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentos_app/models/post_model.dart';
import 'package:mentos_app/models/social_app_model.dart';
import 'package:mentos_app/modules/social_app/chats/chat_screen.dart';
import 'package:mentos_app/modules/social_app/home_screen.dart';
import 'package:mentos_app/modules/social_app/posts_screen.dart';
import 'package:mentos_app/modules/setting/setting_screen.dart';
import 'package:mentos_app/modules/social_app/users_screen.dart';
import 'package:mentos_app/shared/local/cach_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SocialAppCubit extends Cubit<SocialAppStates> {
  SocialAppCubit() : super(SocialAppInitialStates());

  static SocialAppCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility;
  int currentIndex = 0;
  SocialUserModel? userModel;
  PostModel? postModel;
  File? profileImage;
  File? coverImage;
  final picker = ImagePicker();
  String? imageUrl = '';
  String? postImageUrl = '';
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
    if (index == 1) {
      getAllUserData();
    }
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
    emit(UpdateUserDataLoadingStates());
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
        .update(model.toMap())
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
    final fileName = Uri.file(profileImage!.path).pathSegments.last;
    final uniqueFileName = '${DateTime.now().millisecondsSinceEpoch}$fileName';
    imageUrl = supabase.storage.from('users').getPublicUrl(uniqueFileName);
    await supabase.storage
        .from('users')
        .upload(
          uniqueFileName,
          profileImage!,
          fileOptions: FileOptions(upsert: true),
        )
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
    final fileName = Uri.file(coverImage!.path).pathSegments.last;
    final uniqueFileName = '${DateTime.now().millisecondsSinceEpoch}$fileName';
    coverUrl = supabase.storage.from('users').getPublicUrl(uniqueFileName);
    await supabase.storage
        .from('users')
        .upload(
          uniqueFileName,
          coverImage!,
          fileOptions: FileOptions(upsert: true),
        )
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

  File? postImage;

  Future<void> pickPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  Future<void> uploadPostImage({
    required String? created_at,
    required String? text,
  }) async {
    emit(UploadPostImageLoadingState());
    final fileName = Uri.file(postImage!.path).pathSegments.last;
    final uniqueFileName = '${DateTime.now().millisecondsSinceEpoch}$fileName';
    postImageUrl = supabase.storage.from('posts').getPublicUrl(uniqueFileName);
    await supabase.storage
        .from('posts')
        .upload(
          uniqueFileName,
          postImage!,
          fileOptions: FileOptions(upsert: true),
        )
        .then((value) {
          print(value);
          createPost(
            created_at: created_at,
            text: text,
            postImage: postImageUrl,
          );
          getPostsData();
          print('✅ File uploaded successfully: $postImageUrl');
        })
        .catchError((error) {
          print('❌ Error uploading file: $error');
          emit(UploadPostImageErrorState(error.toString()));
        });
  }

  void createPost({
    required String? created_at,
    required String? text,
    String? postImage,
    int? likes = 0,
    int? comments = 0,
  }) async {
    emit(CreatePostLoadingState());
    PostModel model = PostModel(
      id: userModel!.id,
      name: userModel!.name,
      image: userModel!.image,
      likes: likes,
      comments: comments,
      text: text,
      created_at: created_at,
      postImage: postImage,
    );
    await supabase
        .from('posts')
        .insert(model.toMap())
        .then((value) {
          emit(CreatePostSuccessState());
          print('✅ تم تحديث البيانات بنجاح');
        })
        .catchError((error) {
          print('❌ خطأ في تحديث البيانات: $error');
          emit(CreatePostErrorState(error.toString()));
        });
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageSuccessState());
  }

  List<PostModel> posts = [];
  List<String> idPost = [];
  List<int> likes = [];

  void getPostsData() async {
    emit(SocialGetPostsDataLoadingStates());
    await supabase
        .from('posts')
        .select()
        .then((value) {
          print(value.length);
          posts = [];
          for (var element in value) {
            posts.add(PostModel.fromJson(element));
            idPost.add(element['idPost']);
          }
          emit(SocialGetPostsDataSuccessStates());
          print(idPost.toList());
        })
        .catchError((error) {
          print('❌ Error getting user data: $error');
          emit(SocialGetPostsDataErrorStates(error.toString()));
        });
  }

  List<SocialUserModel> users = [];

  void getAllUserData() async {
    emit(SocialGetAllUserDataLoadingStates());
    await supabase
        .from('users')
        .select()
        .then((value) {
          users = [];
          for (var element in value) {
            if (element['id'] != id)
              users.add(SocialUserModel.fromJson(element));
          }
          emit(SocialGetAllUserDataSuccessStates());
        })
        .catchError((error) {
          print('❌ Error getting user data: $error');
          emit(SocialGetAllUserDataErrorStates(error.toString()));
        });
  }

  List<Map<String, dynamic>> messages = [];

  void startListeningToMessages() {
    supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .order('timestamp')
        .listen((event) {
      messages.clear(); // أو تحدد منطق التحديث حسب الحالة
      messages.addAll(event);
      emit(SocialGetMessagesSuccessStates());
    });
  }

  Future<void> sendMessage(String content, String senderId) async {
    emit(SocialSendMessagesLoadingStates());

    await supabase
        .from('messages')
        .insert({
      'content': content,
      'sender_id': senderId,
      'timestamp': DateTime.now().toIso8601String(),
    })
        .then((value) {
      emit(SocialSendMessagesSuccessStates());
      print('✅ تم ارسال الرسالة بنجاح');
    })
        .catchError((error) {
      print('❌ خطأ في ارسال الرسالة: ${error.toString()}');
      emit(SocialSendMessagesErrorStates(error.toString()));
    });
  }

  // Future<void> likePost(String? postId, String? userId) async {
  //   await supabase
  //       .from('likes')
  //       .insert({'idPost': postId, 'userId': userId})
  //       .then((value) {
  //         emit(LikePostSuccessState());
  //         final postIndex = posts.indexWhere((p) => p.postId == postId);
  //         if (postIndex != -1) {
  //           final oldPost = posts[postIndex];
  //           final updatedPost = PostModel(
  //             id: oldPost.id,
  //             name: oldPost.name,
  //             image: oldPost.image,
  //             text: oldPost.text,
  //             created_at: oldPost.created_at,
  //             postImage: oldPost.postImage,
  //             likes:
  //                 (oldPost.likes ?? 0) + 1, // If PostModel has 'likes' as count
  //           );
  //           posts[postIndex] = updatedPost;
  //           emit(SocialGetPostsDataSuccessStates());
  //         }
  //       })
  //       .catchError((error) {
  //         print(error.toString());
  //         emit(LikePostErrorState(error.toString()));
  //       });
  // }
}
