import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mentos_app/bloc_observer/bloc_observer.dart';
import 'package:mentos_app/layout/social_app/cubit/cubit.dart';
import 'package:mentos_app/layout/social_app/social_layout.dart';
import 'package:mentos_app/modules/social_login/cubit/cubit.dart';
import 'package:mentos_app/modules/social_login/social_login_screen.dart';
import 'package:mentos_app/modules/social_register/cubit/cubit.dart';
import 'package:mentos_app/shared/local/cach_helper.dart';
import 'package:mentos_app/style/themes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'componant/constant.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CachHelper.init();
  await Supabase.initialize(
    url: supabaseUrl, // Replace with your Supabase project URL
    anonKey: supabaseKey,// Replace with your Supabase anon key
  );
  Widget? widget;
  id = CachHelper.getData(key: 'uid');
  if (id != null) {
    widget = SocialAppLayout();
  } else if (id == null) {
    widget = SocialLoginScreen();
  }
  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  Widget? startWidget;

  MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => SocialAppCubit()..getUsersData()..getPostsData()..startListeningToMessages(),
        ),
        BlocProvider(create: (BuildContext context) => SocialAppLoginCubit()),
        BlocProvider(
          create: (BuildContext context) => SocialAppRegisterCubit(),
        ),
      ],
      child: MaterialApp(
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}
