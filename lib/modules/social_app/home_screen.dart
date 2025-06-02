import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:mentos_app/layout/social_app/cubit/cubit.dart';
import 'package:mentos_app/layout/social_app/cubit/states.dart';
import 'package:mentos_app/models/social_app_model.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = SocialAppCubit.get(context);
        if(cubit.userModel==null){
          return Center(child: CircularProgressIndicator());
        }else{
          return Scaffold(
            body: SingleChildScrollView(
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
                        (context, index) => _buildPostCard(cubit.userModel),
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemCount: 10,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

var _commentController = TextEditingController();

Widget _buildPostCard(SocialUserModel? model) => Card(
  elevation: 2.0,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // معلومات المستخدم
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
                    '5/22/2025 - 7:27 PM',
                    style: TextStyle(color: Colors.grey, fontSize: 12.0),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        // نص المنشور
        const Text(
          'is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
          style: TextStyle(fontSize: 14.0, height: 1.5),
        ),
        const SizedBox(height: 8.0),
        // الهاشتاج
        Text(
          '#Software',
          style: TextStyle(
            color: Colors.blue[700],
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16.0),
        // صورة داخل المنشور
        Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: const DecorationImage(
              image: NetworkImage(
                'https://img.freepik.com/free-photo/abstract-textured-backgound_1258-30436.jpg?semt=ais_hybrid&w=740',
              ),
              // صورة تقديرية
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        // قسم الإعجابات والتعليقات
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
                  const Text('120', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  const Icon(IconBroken.Chat, color: Colors.amber, size: 20),
                  const SizedBox(width: 4.0),
                  const Text(
                    '250 Comments',
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
            const CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(
                'https://img.freepik.com/free-photo/medium-shot-contemplative-man-seaside_23-2150531590.jpg?t=st=1748189681~exp=1748193281~hmac=9e8b1c668f77d46038c6e06a47490216028ecc5fd8a22a16e5803cbbffedec96&w=1380',
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
              onTap: () {},
              child: const Icon(
                Icons.favorite_border,
                color: Colors.pink,
                size: 24,
              ),
            ),
            // أيقونة الإعجاب
          ],
        ),
      ],
    ),
  ),
);
