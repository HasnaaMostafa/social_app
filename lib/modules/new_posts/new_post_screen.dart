import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sociall_app_2/shared/components/components.dart';
import 'package:sociall_app_2/shared/components/constatnts.dart';
import 'package:sociall_app_2/shared/cubits/socialAppCubit.dart';
import 'package:sociall_app_2/shared/cubits/socialAppStates.dart';

import '../../shared/style/iconBroken.dart';

class NewPostsScreen extends StatelessWidget {
  NewPostsScreen({super.key});

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, Object? state) {
        if (state is SocialUploadPostSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: "Create Post", actions: [
            TextButton(
                onPressed: () {
                  var now = DateTime.now();
                  if (SocialCubit.get(context).postImage == null) {
                    SocialCubit.get(context).createPost(
                        text: textController.text, dateTime: now.toString());
                  } else {
                    SocialCubit.get(context).uploadPostImage(
                        text: textController.text, dateTime: now.toString());
                  }
                },
                child: Text(
                  "POST",
                  style: TextStyle(color: defaultColor),
                ))
          ]),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Column(
              children: [
                if (state is SocialUploadPostLoadingState)
                  LinearProgressIndicator(
                    color: Colors.grey,
                    backgroundColor: defaultColor,
                  ),
                if (state is SocialUploadPostLoadingState)
                  const SizedBox(
                    height: 10,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                            "${SocialCubit.get(context).usermodel?.image}" ??
                                "")),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "${SocialCubit.get(context).usermodel?.name}" ?? "",
                        style: const TextStyle(
                            height: 1.3,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: TextFormField(
                      controller: textController,
                      decoration: const InputDecoration(
                        hintText: "what is on your mind ",
                        border: InputBorder.none,
                      )),
                ),
                if (SocialCubit.get(context).postImage != null)
                  const SizedBox(
                    height: 20,
                  ),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                              image: FileImage(
                                  SocialCubit.get(context).postImage!),
                              fit: BoxFit.cover,
                            )),
                      ),
                      IconButton(
                          onPressed: () {
                            SocialCubit.get(context).removePostImage();
                          },
                          icon: CircleAvatar(
                            backgroundColor: defaultColor2,
                            radius: 20,
                            child: const Icon(
                              IconBroken.Close_Square,
                              size: 16,
                            ),
                          )),
                    ],
                  ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconBroken.Image,
                                color: defaultColor,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "add photo",
                                style: TextStyle(color: defaultColor),
                              )
                            ],
                          )),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "# tags",
                          style: TextStyle(color: defaultColor),
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
