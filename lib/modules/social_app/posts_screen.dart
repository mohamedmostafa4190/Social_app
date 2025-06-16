import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:mentos_app/componant/component.dart';
import 'package:mentos_app/layout/social_app/cubit/cubit.dart';
import 'package:mentos_app/layout/social_app/cubit/states.dart';

class PostsScreen extends StatelessWidget {

  var newPostController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {
      if(state is CreatePostLoadingState){
          newPostController.text = '';
          SocialAppCubit.get(context).removePostImage();
          showToast(text: 'تم نشر المنشور بنجاح', states: ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        final cubit = SocialAppCubit.get(context);
        final model = cubit.userModel;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Create Post',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (cubit.postImage == null) {
                    cubit.createPost(
                      created_at: DateTime.now().toString(),
                      text: newPostController.text,
                      postImage: cubit.postImageUrl,

                    );
                  } else {
                    cubit.uploadPostImage(
                      created_at: DateTime.now().toString(),
                      text: newPostController.text,
                    );
                  }
                },
                child: Text('POST', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                if(state is CreatePostLoadingState || state is UploadPostImageLoadingState)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(bottom: 10,top: 5),
                    child: LinearProgressIndicator(),
                  ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage('${model!.image}'), //
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
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
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: TextFormField(
                    minLines: 1,
                    maxLines: 100,
                    controller: newPostController,
                    decoration: InputDecoration(
                      hintText: 'write is on your mind',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (cubit.postImage != null)
                  Expanded(
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: FileImage(cubit.postImage!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          child: IconButton(
                            onPressed: () {
                              cubit.removePostImage();
                            },
                            icon: Icon(Icons.close),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          cubit.pickPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(IconBroken.Image, color: Colors.blue),
                            SizedBox(width: 5),
                            Text(
                              'Add Photo',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          '#tags',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
