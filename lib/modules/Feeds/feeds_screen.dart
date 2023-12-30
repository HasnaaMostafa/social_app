import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sociall_app_2/models/post_model.dart';
import 'package:sociall_app_2/models/user_model.dart';
import 'package:sociall_app_2/modules/Feeds/post_image_screen.dart';
import 'package:sociall_app_2/modules/comments/comments_screen.dart';
import 'package:sociall_app_2/shared/cubits/socialAppCubit.dart';
import 'package:sociall_app_2/shared/cubits/socialAppStates.dart';
import 'package:sociall_app_2/shared/style/iconBroken.dart';

import '../../shared/components/components.dart';
import '../../shared/components/show_modal_button_sheet.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({
    super.key,
  });

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  UserModel? userModel;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, Object? state) {
        return ConditionalBuilder(
            condition: SocialCubit.get(context).posts.isNotEmpty &&
                SocialCubit.get(context).usermodel != null,
            builder: (BuildContext context) => LiquidPullToRefresh(
                  color: Colors.grey,
                  onRefresh: SocialCubit.get(context).handleRefresh,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 10,
                          margin: const EdgeInsets.all(8),
                          child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                const Image(
                                  image: AssetImage("assets/images/feed.jpg"),
                                  fit: BoxFit.cover,
                                  height: 170,
                                  width: double.infinity,
                                ),
                                Text(
                                  "Communicate                                    "
                                  "With Friends",
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                        ),
                        ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) =>
                                buildPostItem(
                                    SocialCubit.get(context).posts[index],
                                    context,
                                    index),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                                      height: 8,
                                    ),
                            itemCount: SocialCubit.get(context).posts.length)
                      ],
                    ),
                  ),
                ),
            fallback: (BuildContext context) =>
                const Center(child: CircularProgressIndicator()));
      },
    );
  }
}

Widget buildPostItem(PostModel model, context, index) => Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(model.image!),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${model.name}",
                          style: const TextStyle(
                              height: 1.3,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 16,
                        )
                      ],
                    ),
                    Text(
                      "${model.dateTime}",
                      style: const TextStyle(
                        height: 1.2,
                        fontSize: 10,
                      ),
                    )
                  ],
                )),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () {
                      showModelBottomSheet(context, model, index);
                    },
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 16,
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 13),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            Text(
              "${model.text}",
              style: const TextStyle(
                  height: 1.3, fontSize: 14, fontWeight: FontWeight.bold),
            ),
            if (model.postImage != "")
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PostImageScreen(postModel: model)));
                },
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(top: 15),
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                          image: NetworkImage("${model.postImage}"),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            const Icon(
                              IconBroken.Heart,
                              size: 17,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${SocialCubit.get(context).likes[index]}",
                              style: const TextStyle(fontSize: 14),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        // SocialCubit.get(context).getLikesCount(
                        //     SocialCubit.get(context).postsId[index]);
                      },
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              IconBroken.Chat,
                              size: 17,
                              color: Colors.amber,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${SocialCubit.get(context).comments[index]}",
                              style: const TextStyle(fontSize: 14),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        SocialCubit.get(context).getComments(
                            SocialCubit.get(context).postsId[index]);
                        navigateTo(context, const CommentScreen());
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(
                              "${SocialCubit.get(context).usermodel!.image}"),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "write a comment",
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ),
                    onTap: () {
                      SocialCubit.get(context).getComments(model.uId!);

                      navigateTo(context, const CommentScreen());
                    },
                  ),
                ),
                InkWell(
                  child: const Row(
                    children: [
                      Icon(
                        IconBroken.Heart,
                        size: 17,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Like",
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                  onTap: () {
                    SocialCubit.get(context)
                        .likePost(SocialCubit.get(context).postsId[index]);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );

// Padding(
//   padding: const EdgeInsets.only(
//     bottom: 10,
//     top: 5,
//   ),
//   child: SizedBox(
//     width: double.infinity,
//     child: Wrap(
//       children: [
//         Padding(
//           padding: const EdgeInsetsDirectional.only(
//               end: 6
//           ),
//           child: SizedBox(
//             height: 20,
//             child: MaterialButton(
//               onPressed: (){},
//               minWidth: 1,
//               padding: EdgeInsets.zero,
//               child: const Text(
//                 "#software",
//                 style: TextStyle(
//                   color: Colors.blue,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsetsDirectional.only(
//             end: 6,),
//           child: SizedBox(
//             height: 20,
//             child: MaterialButton(
//               onPressed: (){},
//               minWidth: 1,
//               padding: EdgeInsets.zero,
//               child: const Text(
//                 "#software",
//                 style: TextStyle(
//                     color: Colors.blue
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsetsDirectional.only(
//               end: 10),
//           child: SizedBox(
//             height: 20,
//             child: MaterialButton(
//               onPressed: (){},
//               minWidth: 1,
//               padding: EdgeInsets.zero,
//               child: const Text(
//                 "#software",
//                 style: TextStyle(
//                     color: Colors.blue
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsetsDirectional.only(
//               end: 10),
//           child: SizedBox(
//             height: 20,
//             child: MaterialButton(
//               onPressed: (){},
//               minWidth: 1,
//               padding: EdgeInsets.zero,
//               child: const Text(
//                 "#software_development",
//                 style: TextStyle(
//                     color: Colors.blue
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsetsDirectional.only(
//               end: 10),
//           child: SizedBox(
//             height: 20,
//             child: MaterialButton(
//               onPressed: (){},
//               minWidth: 1,
//               padding: EdgeInsets.zero,
//               child: const Text(
//                 "#software_development",
//                 style: TextStyle(
//                     color: Colors.blue
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
