import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:mentos_app/componant/component.dart';
import 'package:mentos_app/layout/social_app/cubit/cubit.dart';
import 'package:mentos_app/layout/social_app/cubit/states.dart';
import 'package:mentos_app/models/post_model.dart';
import 'package:mentos_app/models/social_app_model.dart';

import '../../componant/constant.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {
        if (state is CreatePostSuccessState) {
          SocialAppCubit.get(context).getPostsData();
        }
      },
      builder: (context, state) {
        final cubit = SocialAppCubit.get(context);
        if (cubit.userModel == null) {
          return Center(child: CircularProgressIndicator());
        } else {
          return RefreshIndicator(
            onRefresh:
                () async => context.read<SocialAppCubit>().getPostsData(),
            child: ConditionalBuilder(
              condition: cubit.posts.length >= 0,
              builder:
                  (context) => SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 10,
                          margin: EdgeInsets.all(9),
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Image(
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  'https://img.freepik.com/free-photo/abstract-textured-backgound_1258-30436.jpg',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Communicate with your friends',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder:
                              (context, index) => _buildPostCard(
                                cubit.posts[index],
                                cubit,
                                index,
                              ),
                          separatorBuilder:
                              (context, index) => SizedBox(height: 10),
                          itemCount: cubit.posts.length,
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          );
        }
      },
    );
  }
}

var _commentController = TextEditingController();

Widget _buildPostCard(PostModel? model, SocialAppCubit? cubit, index) => Card(
  elevation: 2.0,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                '${model!.image}',
              ), // صورة ملف شخصي تقديرية
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${model.name}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                          maxLines: 3,
                        ),
                      ),
                      Icon(Icons.verified, color: Colors.blue, size: 16),
                      // أيقونة التحقق
                      IconButton(
                        icon: const Icon(Icons.more_horiz, color: Colors.grey),
                        onPressed: () {
                          // قم بتنفيذ الإجراء عند النقر على أيقونة المزيد
                        },
                      ),
                    ],
                  ),
                  Text(
                    formatDate('${model.created_at}'),
                    style: TextStyle(color: Colors.grey, fontSize: 12.0),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Text('${model.text}', style: TextStyle(fontSize: 14.0, height: 1.5)),
        const SizedBox(height: 8.0),
        Text(
          '#Software',
          style: TextStyle(
            color: Colors.blue[700],
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16.0),
        if (model.postImage != '' && model.postImage == null)
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: NetworkImage('${model.postImage}'),
                // صورة تقديرية
                fit: BoxFit.cover,
              ),
            ),
          ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  const Icon(
                    Icons.favorite_border,
                    color: Colors.pink,
                    size: 20,
                  ),
                  const SizedBox(width: 4.0),
                  Text('0', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  const Icon(IconBroken.Chat, color: Colors.amber, size: 20),
                  const SizedBox(width: 4.0),
                  Text(
                    '${model.comments} Comments',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(height: 24.0), // فاصل
        // قسم كتابة التعليق
        Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(
                '${cubit!.userModel!.image}',
              ), // صورة ملف شخصي
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: TextField(
                onTap: () {},
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: 'write a comment...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  // إزالة حدود
                  isDense: true,
                  // لتقليل الارتفاع الافتراضي
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            InkWell(
              onTap: () {
                // cubit.likePost(cubit.idPost[index],id);
              },
              child: Row(
                children: [
                  Icon(Icons.favorite_border, color: Colors.pink, size: 24),
                  SizedBox(width: 2),
                  Text('Like'),
                ],
              ),
            ),
            // أيقونة الإعجاب
          ],
        ),
      ],
    ),
  ),
);
