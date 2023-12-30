import 'package:flutter/material.dart';

import '../../models/post_model.dart';
import '../cubits/socialAppCubit.dart';
import 'app_button.dart';

Future<dynamic> showModelBottomSheet(context, PostModel model, int index) {
  return showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      context: context,
      builder: (BuildContext context) => SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  width: 100,
                  child: Divider(
                    thickness: 5,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                appButton(
                  function: () {
                    SocialCubit.get(context)
                        .deletePost(SocialCubit.get(context).postsId[index]);
                    Navigator.pop(context);
                  },
                  background: const Color(0xffCD5C5C),
                  text: "Delete Post",
                ),
                SizedBox(
                  width: double.infinity,
                  child: Divider(
                    thickness: 2,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                appButton(
                  function: () {
                    Navigator.pop(context);
                  },
                  background: Colors.grey.withOpacity(0.7),
                  text: "Cancel",
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ));
}
