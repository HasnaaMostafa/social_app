import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sociall_app_2/models/comment_model.dart';
import 'package:sociall_app_2/shared/components/constatnts.dart';
import 'package:sociall_app_2/shared/cubits/socialAppCubit.dart';
import 'package:sociall_app_2/shared/cubits/socialAppStates.dart';
import 'package:sociall_app_2/shared/style/iconBroken.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  String? postId;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, Object? state) {
        if (state is SocialCommentPostSuccessState) {
          BlocProvider.of<SocialCubit>(context).getComments(postId!);
        }
      },
      builder: (BuildContext context, Object? state) {
        var commentController = TextEditingController();

        return Scaffold(
          appBar: AppBar(
            title: const Text("Comments"),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                SocialCubit.get(context).getPosts();
              },
              icon: const Icon(IconBroken.Arrow___Left_2),
            ),
          ),
          body: Column(
            children: [
              ConditionalBuilder(
                condition: SocialCubit.get(context).commentModelList.isNotEmpty,
                builder: (BuildContext context) => SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) =>
                        buildCommentItem(
                            SocialCubit.get(context).commentModelList[index],
                            context,
                            index),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 10,
                    ),
                    itemCount: SocialCubit.get(context).commentModelList.length,
                  ),
                ),
                fallback: (BuildContext context) =>
                    const Center(child: Text("No comments")),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 10),
                child: TextFormField(
                  autofocus: true,
                  controller: commentController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: defaultColor, width: 2),
                      ),
                      hintText: "write a comment ",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: HexColor("#0E6655")),
                      filled: true),
                  onFieldSubmitted: (value) {
                    postId = SocialCubit.get(context).newPostId.toString();
                    DateTime now = DateTime.now();
                    String formattedDate =
                        DateFormat("yyyy-MM-dd -kk:mm").format(now);

                    SocialCubit.get(context).commentPost(
                        postId: postId!,
                        comment: commentController.text,
                        dateTime: formattedDate.toString());

                    FocusScope.of(context).unfocus();
                    commentController.clear();
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

Widget buildCommentItem(CommentModel model, context, index) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("${model.userImage}"),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Container(
                  height: 100,
                  clipBehavior: Clip.hardEdge,
                  padding: const EdgeInsets.fromLTRB(5, 15, 10, 0),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${model.name}",
                            style:
                                TextStyle(height: 1.4, color: Colors.grey[800]),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 16,
                          ),
                        ],
                      ),
                      Text("${model.dateTime}",
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 14)),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        "${model.text}",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(color: Colors.grey[800]),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}
