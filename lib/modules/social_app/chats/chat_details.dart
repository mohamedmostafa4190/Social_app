import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:mentos_app/layout/social_app/cubit/cubit.dart';
import 'package:mentos_app/layout/social_app/cubit/states.dart';
import 'package:mentos_app/models/social_app_model.dart';

class ChatScreenDetails extends StatelessWidget {
  SocialUserModel userModel;
  final messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  ChatScreenDetails(this.userModel);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {
      if (scrollController.hasClients) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      }
      if(state is SocialSendMessagesSuccessStates){
       SocialAppCubit.get(context).startListeningToMessages();
      }
      },
      builder: (context, state) {
        final cubit = SocialAppCubit.get(context);
        final myId = SocialAppCubit.get(context).userModel!.id;
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    '${userModel.image}',
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
                              '${userModel.name}',
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
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  controller: ScrollController(),
                  itemBuilder:(context, index) {
                    final isMyMessage = cubit.messages[index]['sender_id'] == myId;
                  return  Align(
                      alignment: isMyMessage?AlignmentDirectional.centerEnd:AlignmentDirectional.centerStart,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          height: 30,
                          padding: EdgeInsetsDirectional.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),

                          decoration: BoxDecoration(
                            color:isMyMessage ? Colors.grey[300]: Colors.lightBlue[300],

                            borderRadius: BorderRadiusDirectional.only(
                              bottomStart: isMyMessage ? Radius.circular(10) : Radius.circular(0),
                              bottomEnd: isMyMessage ? Radius.circular(0) : Radius.circular(10),
                              topStart: Radius.circular(10),
                              topEnd: Radius.circular(10),
                            ),
                          ),
                          child: Text(
                            '${cubit.messages[index]['content']}',
                          ),
                        ),
                      ),
                    );
                  },

                  itemCount: cubit.messages.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey, width: 1.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: messageController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '\t type your message here...',
                          ),
                        ),
                      ),
                      MaterialButton(
                        height: 48,
                        minWidth: 1,
                        color: Colors.blue[300],
                        onPressed: () {
                          cubit.sendMessage(
                            messageController.text,
                            userModel.id!,
                          );
                          messageController.clear();
                        },
                        child: Icon(IconBroken.Send),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
