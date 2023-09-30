import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sociall_app_2/models/user_model.dart';
import 'package:sociall_app_2/shared/components/components.dart';
import 'package:sociall_app_2/shared/cubits/socialAppCubit.dart';
import 'package:sociall_app_2/shared/cubits/socialAppStates.dart';

import '../ChatDetails/chat_details_screen.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, Object? state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.isNotEmpty,
          builder: (BuildContext context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) =>
                  buildChatItem(SocialCubit.get(context).users[index], context),
              separatorBuilder: (BuildContext context, int index) =>
                  myDivider(),
              itemCount: SocialCubit.get(context).users.length),
          fallback: (BuildContext context) =>
              const Center(child: Text("No chats!")),
        );
      },
    );
  }

  Widget buildChatItem(UserModel model, context) => InkWell(
        onTap: () {
          navigateTo(
              context,
              ChatDetailsScreen(
                userModel: model,
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage("${model.image}"),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                "${model.name}",
                style: const TextStyle(
                    height: 1.3, fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ],
          ),
        ),
      );
}
