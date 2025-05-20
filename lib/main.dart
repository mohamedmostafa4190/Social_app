import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mentos_app/bloc_observer/bloc_observer.dart';
import 'package:mentos_app/layout/social_app/cubit/cubit.dart';
import 'package:mentos_app/layout/social_app/social_app.dart';
import 'package:mentos_app/modules/social_app/social_login_screen.dart';
import 'package:mentos_app/modules/social_app/social_register_screen.dart';
import 'package:mentos_app/shared/local/cach_helper.dart';
import 'package:mentos_app/style/themes.dart';
import 'package:mentos_app/test_payment_screen.dart';

import 'componant/constant.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CachHelper.init();
  Stripe.publishableKey = 'your_publishable_key_here';
  Widget widget;
  uid = CachHelper.getData(key: 'uid');
  if (uid != null) {
    widget = SocialAppLayout();
  } else {
    widget = SocialLoginScreen();
  }
  runApp(MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  Widget? startWidget;

  MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialAppCubit(),
      child: MaterialApp(
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}
