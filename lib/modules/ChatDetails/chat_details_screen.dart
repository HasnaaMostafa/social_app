import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sociall_app_2/models/message_model.dart';
import 'package:sociall_app_2/models/user_model.dart';
import 'package:sociall_app_2/shared/components/constatnts.dart';
import 'package:sociall_app_2/shared/cubits/socialAppCubit.dart';
import 'package:sociall_app_2/shared/cubits/socialAppStates.dart';
import 'package:sociall_app_2/shared/style/iconBroken.dart';

class ChatDetailsScreen extends StatelessWidget {
  ChatDetailsScreen({super.key, this.userModel});

  UserModel? userModel;

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessages(receiverId: userModel!.uId!);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (BuildContext context, Object? state) {},
          builder: (BuildContext context, Object? state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage("${userModel!.image}"),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text("${userModel!.name}"),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        reverse: true,
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              var message =
                                  SocialCubit.get(context).message[index];
                              if (SocialCubit.get(context).usermodel!.uId ==
                                  message.senderId) {
                                return buildSendMessage(message);
                              }
                              return buildReceiverMessage(message);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                                      height: 15,
                                    ),
                            itemCount: SocialCubit.get(context).message.length),
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(15)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: TextFormField(
                                controller: messageController,
                                onFieldSubmitted: (value) {
                                  if (SocialCubit.get(context).chatImage !=
                                      null) {
                                    SocialCubit.get(context).uploadMessageImage(
                                        text: messageController.text,
                                        dateTime:
                                            DateTime.now().toLocal().toString(),
                                        receiverId: userModel!.uId!);
                                  } else {
                                    SocialCubit.get(context).sendMessage(
                                      receiverId: userModel!.uId!,
                                      text: messageController.text,
                                      dateTime:
                                          DateTime.now().toLocal().toString(),
                                    );
                                    FocusScope.of(context).unfocus();
                                    messageController.clear();
                                  }
                                },
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        SocialCubit.get(context)
                                            .getMessageImage();
                                      },
                                      icon: Icon(
                                        IconBroken.Image,
                                        color: defaultColor,
                                      ),
                                    ),
                                    hintText: "Type your message here...",
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            color: defaultColor,
                            child: MaterialButton(
                              minWidth: 1,
                              onPressed: () {
                                if (SocialCubit.get(context).chatImage !=
                                    null) {
                                  SocialCubit.get(context).uploadMessageImage(
                                      text: messageController.text,
                                      dateTime:
                                          DateTime.now().toLocal().toString(),
                                      receiverId: userModel!.uId!);
                                } else {
                                  SocialCubit.get(context).sendMessage(
                                    receiverId: userModel!.uId!,
                                    text: messageController.text,
                                    dateTime:
                                        DateTime.now().toLocal().toString(),
                                  );
                                  FocusScope.of(context).unfocus();
                                  messageController.clear();
                                }
                                SocialCubit.get(context).chatImage = null;
                              },
                              child: const Icon(
                                IconBroken.Send,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildReceiverMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Column(
          children: [
            if (model.text != "")
              Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadiusDirectional.only(
                        bottomEnd: Radius.circular(10),
                        topEnd: Radius.circular(10),
                        topStart: Radius.circular(10),
                      )),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text("${model.text}",
                      style: const TextStyle(fontSize: 17))),
            if (model.chatImage != null && model.chatImage != "")
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(model.chatImage!),
                        fit: BoxFit.cover)),
              ),
          ],
        ),
      );

  Widget buildSendMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Column(
          children: [
            if (model.text != "")
              Container(
                  decoration: BoxDecoration(
                      color: defaultColor2.withOpacity(0.5),
                      borderRadius: const BorderRadiusDirectional.only(
                        bottomStart: Radius.circular(10),
                        topEnd: Radius.circular(10),
                        topStart: Radius.circular(10),
                      )),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(
                    "${model.text}",
                    style: const TextStyle(fontSize: 17),
                  )),
            if (model.chatImage != null && model.chatImage != "")
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(model.chatImage!),
                        fit: BoxFit.cover)),
              ),
          ],
        ),
      );
}
