import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:mentos_app/componant/component.dart';
import 'package:mentos_app/layout/social_app/cubit/cubit.dart';
import 'package:mentos_app/layout/social_app/cubit/states.dart';
import 'package:mentos_app/modules/social_login/social_login_screen.dart';
import 'package:mentos_app/shared/local/cach_helper.dart';

import 'edit_profile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {
        if (state is LogOutSuccessStates) {
          showToast(text: 'تم تسجيل الخروج بنجاح', states: ToastStates.SUCCESS);
          navigatePushAndRemove(context, widget: SocialLoginScreen());
        } else if (state is LogOutErrorStates) {
          showToast(text: state.error, states: ToastStates.ERROR);
          print(state.error);
        }
      },
      builder: (context, state) {
        var userModel = SocialAppCubit.get(context).userModel;
        var cubit = SocialAppCubit.get(context);
        if (userModel == null) {
          return Center(child: CircularProgressIndicator());
        }
        return ConditionalBuilder(
          condition: state is !SocialGetUserDataLoadingStates,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          width: double.infinity,
                          height: 170,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage('${userModel.profileCover}'),
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 50,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage('${userModel.image}'),
                          radius: 45,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '${userModel.name}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                Text(
                  '${userModel.bio}',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '100',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            'Post',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '100',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            'Post',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '100',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            'Post',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '100',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            'Post',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 35),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ), // نصف قطر الزاوية
                          ),
                        ),
                        child: Text('Edit profile'),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          navigatePush(context, widget: EditProfileScreen());
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Icon(IconBroken.Edit),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 100),
                Container(
                  width: double.infinity,
                  child: ConditionalBuilder(
                    condition: state is! LogOutLoadingStates,
                    builder:
                        (context) => OutlinedButton(
                      onPressed: () {
                        cubit.logOut();
                        CachHelper.removeData('uid');
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ), // نصف قطر الزاوية
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(IconBroken.Logout),
                          SizedBox(width: 15),
                          Text('LOG OUT'),
                        ],
                      ),
                    ),
                    fallback: (context) => LinearProgressIndicator(),
                  ),
                ),
              ],
            ),
          ),
          fallback:(context) =>  Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
