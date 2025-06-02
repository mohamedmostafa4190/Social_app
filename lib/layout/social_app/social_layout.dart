import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:mentos_app/componant/component.dart';
import 'package:mentos_app/layout/social_app/cubit/cubit.dart';
import 'package:mentos_app/layout/social_app/cubit/states.dart';
import 'package:mentos_app/modules/social_app/posts_screen.dart';

class SocialAppLayout extends StatelessWidget {
  const SocialAppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {
        if(state is AddPostStates){
          navigatePush(context, widget: PostsScreen());
        }
      },
      builder: (context, state) {
        final cubit = SocialAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications_none_sharp),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Chat),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Send),
                label: 'Posts',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Location),
                label: 'User',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Setting),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
