import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentos_app/componant/constant.dart';
import 'package:mentos_app/models/social_app_model.dart';
import 'package:mentos_app/modules/social_register/cubit/states.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SocialAppRegisterCubit extends Cubit<SocialAppRegisterStates> {
  SocialAppRegisterCubit() : super(SocialAppRegisterInitialStates());

  static SocialAppRegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility;
  SocialUserModel? model;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ChangePasswordVisibilityStates());
  }

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    emit(SocialAppRegisterLoadingStates());
    await supabase.auth
        .signUp(email: email, password: password)
        .then((value) async {
          await supabase.from('users').insert({
            'id': value.user!.id,
            'name': name,
            'phone': phone,
            'email': email,
          });
          print(email);
          emit(SocialAppRegisterSuccessStates());
        })
        .catchError((error) {
          print('ERROR!!!${error.toString()}');
          emit(SocialAppRegisterErrorStates(error.toString()));
        });
  }

  // void userCreate({
  //   required String name,
  //   required String phone,
  //   required String email,
  //   required String uid,
  // }) {
  //   SocialUserModel model = SocialUserModel(
  //     name: name,
  //     email: email,
  //     phone: phone,
  //     uId: uid,
  //     bio: 'write your bio......',
  //     image:
  //         'https://img.freepik.com/premium-vector/vector-flat-illustration-grayscale-avatar-user-profile-person-icon-gender-neutral-silhouette-profile-picture-suitable-social-media-profiles-icons-screensavers-as-templatex9xa_719432-875.jpg',
  //     isEmailVerified: false,
  //     profileCover:
  //         'https://img.freepik.com/free-photo/abstract-textured-backgound_1258-30436.jpg',
  //   );
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(uid)
  //       .set(model.toJson())
  //       .then((value) {
  //         emit(SocialCreateUserSuccessStates(uid));
  //       })
  //       .catchError((error) {
  //         emit(SocialCreateUserErrorStates(error.toString()));
  //       });
  // }
}
