import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentos_app/componant/constant.dart';
import 'package:mentos_app/modules/social_login/cubit/states.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SocialAppLoginCubit extends Cubit<SocialAppLoginStates> {
  SocialAppLoginCubit() : super(SocialAppLoginInitialStates());

  static SocialAppLoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ChangePasswordVisibilityStates());
  }

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    emit(SocialAppLoginLoadingStates());
    await supabase.auth
        .signInWithPassword(email: email, password: password)
        .then((value) {
          print(value.user!.email);
          print(value.user!.id);
          emit(SocialAppLoginSuccessStates(value.user!.id));
        })
        .catchError((error) {
          emit(SocialAppLoginErrorStates(error.toString()));
        });
  }
}
