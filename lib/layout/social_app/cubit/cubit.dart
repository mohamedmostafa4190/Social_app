import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mentos_app/layout/social_app/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentos_app/layout/social_app/social_app.dart';
import 'package:mentos_app/models/social_app_model.dart';
import 'package:mentos_app/modules/social_app/chat_screen.dart';
import 'package:mentos_app/modules/social_app/home_screen.dart';
import 'package:mentos_app/modules/social_app/posts_screen.dart';
import 'package:mentos_app/modules/social_app/setting_screen.dart';
import 'package:mentos_app/modules/social_app/users_screen.dart';

class SocialAppCubit extends Cubit<SocialAppStates> {
  SocialAppCubit() : super(SocialAppInitialStates());

  static SocialAppCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility;
  int currentIndex = 0;
  bool? isUid = true;

  final List<Widget> screens = [
    HomeScreen(),
    ChatScreen(),
    PostsScreen(),
    UsersScreen(),
    SettingScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarStates());
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ChangePasswordVisibilityStates());
  }

  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    emit(SocialAppRegisterLoadingStates());
    return await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        )
        .then((value) {
          print(value.user!.email);
          print(value.user!.uid);
          userCreate(
            uid: value.user!.uid,
            email: email,
            phone: phone,
            name: name,
          );
        })
        .catchError((error) {
          emit(SocialAppRegisterErrorStates(error.toString()));
        });
  }

  void userLogin({required String email, required String password}) async {
    emit(SocialAppLoginLoadingStates());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        )
        .then((value) {
          print(value.user!.email);
          print(value.user!.uid);
          emit(SocialAppLoginSuccessStates(value.user!.uid));
        })
        .catchError((error) {
          emit(SocialAppLoginErrorStates(error.toString()));
        });
  }
  void userCreate({
    required String name,
    required String phone,
    required String email,
    required String uid,
  }) {
    UserCreateModel model = UserCreateModel(
      name: name,
      email: email,
      phone: phone,
      uId: uid,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toJson())
        .then((value) {
          emit(SocialCreateUserSuccessStates(uid));
        })
        .catchError((error) {
          emit(SocialCreateUserErrorStates(error.toString()));
        });
  }

  // _______________________________________________________________________________
  Future<void> makePayment({required String paymentIntentClientSecret}) async {
    emit(PaymentLoading());

    await Stripe.instance
        .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentClientSecret,
            merchantDisplayName: 'Your App Name',
          ),
        )
        .then((value) async {
          await Stripe.instance.presentPaymentSheet();

          emit(PaymentSuccess());
        })
        .catchError((error) {
          emit(PaymentError(error: error.toString()));
        });
  }
}
