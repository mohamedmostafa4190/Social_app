import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentos_app/layout/social_app/cubit/cubit.dart';
import 'package:mentos_app/layout/social_app/cubit/states.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text('Add Post',style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),)),
          body: Center(child: Text('Posts Screen')),
        );
      },
    );
  }
}
