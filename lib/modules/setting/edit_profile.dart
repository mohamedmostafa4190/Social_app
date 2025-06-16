import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:mentos_app/componant/component.dart';
import 'package:mentos_app/componant/constant.dart';
import 'package:mentos_app/layout/social_app/cubit/cubit.dart';
import 'package:mentos_app/layout/social_app/cubit/states.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var bioController = TextEditingController();

    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {
        if (state is UpdateUserDataSuccessStates) {
          showToast(text: 'تم تحديث البيانات', states: ToastStates.SUCCESS);
        } else if (state is UpdateUserDataErrorStates) {
          showToast(
            text: 'حدث مشكلة اثناء تحديث البيانات',
            states: ToastStates.ERROR,
          );
        }
        if (state is UploadImageProfileSuccessState) {
          SocialAppCubit.get(context).profileImage = null;
        }else if(state is UploadCoverImageSuccessState){
          SocialAppCubit.get(context).coverImage = null;
        }
      },
      builder: (context, state) {
        var userModel = SocialAppCubit.get(context).userModel;
        var cubit = SocialAppCubit.get(context);
        var formKey = GlobalKey<FormState>();
        var profileImage = cubit.profileImage;
        var coverImage = cubit.coverImage;
        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;

        return Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(IconBroken.Arrow___Left),
            ),
            title: Text(
              'Edit Profile',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            titleSpacing: 0.0,
            actions: [
              TextButton(
                onPressed: () {
                  cubit.updateUser(
                    name: nameController.text,
                    bio: bioController.text,
                    userId: id,
                  );
                },
                child: Text(
                  'UPDATE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (state is UpdateUserDataLoadingStates)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(),
                    ),
                  SizedBox(
                    height: 200,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                width: double.infinity,
                                height: 170,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        coverImage == null
                                            ? NetworkImage(
                                              '${cubit.userModel!.profileCover}',
                                            )
                                            : FileImage(cubit.coverImage!),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  cubit.pickCoverImage();
                                },
                                icon: CircleAvatar(
                                  child: Icon(IconBroken.Camera),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              child: CircleAvatar(
                                backgroundImage:
                                    profileImage == null
                                        ? NetworkImage(
                                          '${cubit.userModel!.image}',
                                        )
                                        : FileImage(cubit.profileImage!),
                                radius: 58,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                cubit.pickProfileImage();
                              },
                              icon: CircleAvatar(
                                child: Icon(IconBroken.Camera),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        if (cubit.profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  onPressed: () {
                                    cubit.uploadProfileImage(
                                      name: nameController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  child: Text('UPLOAD IMAGE'),
                                ),
                              if(state is UploadImageProfileLoadingState)
                                LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        SizedBox(width: 20),
                        if (cubit.coverImage != null)
                          Expanded(
                            child: defaultButton(
                              onPressed: () {
                                cubit.uploadCoverImage(
                                  name: nameController.text,
                                  bio: bioController.text,
                                );
                              },
                              child: Text('UPLOAD COVER'),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  defaultFormField(
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Name must not be empty';
                      }
                      return null;
                    },
                    prefixIcon: IconBroken.Profile,
                    label: 'Name',
                    controller: nameController,
                    type: TextInputType.name,
                    onTap: () {},
                  ),
                  SizedBox(height: 20),
                  defaultFormField(
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Bio must not be empty';
                      }
                      return null;
                    },
                    prefixIcon: IconBroken.Info_Circle,
                    minLines: 3,
                    maxLines: null,
                    label: 'Bio',
                    controller: bioController,
                    type: TextInputType.multiline,
                    onTap: () {},
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
