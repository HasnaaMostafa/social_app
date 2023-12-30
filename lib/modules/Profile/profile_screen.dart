import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sociall_app_2/modules/new_posts/new_post_screen.dart';
import 'package:sociall_app_2/shared/components/components.dart';
import 'package:sociall_app_2/shared/cubits/socialAppCubit.dart';
import 'package:sociall_app_2/shared/cubits/socialAppStates.dart';
import 'package:sociall_app_2/shared/style/iconBroken.dart';

import '../EditProfile/edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, Object state) {},
      builder: (BuildContext context, Object state) {
        var userModel = SocialCubit.get(context).usermodel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 190,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4)),
                            image: DecorationImage(
                              image: NetworkImage("${userModel!.cover}"),
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                    CircleAvatar(
                      radius: 60,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                          radius: 55,
                          backgroundImage: NetworkImage("${userModel.image}")),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "${userModel.name}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "${userModel.bio}",
                style: const TextStyle(color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              "100",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            const Text(
                              "Posts",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              "255",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            const Text(
                              "Photos",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              "10K",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            const Text(
                              "Followers",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              "2000",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            const Text(
                              "Friends",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          navigateTo(context, NewPostsScreen());
                        },
                        child: Text(
                          "Add Photos",
                          style: TextStyle(
                            color: HexColor("#B7950B"),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          navigateTo(context, EditProfile());
                        },
                        child: Icon(
                          IconBroken.Edit,
                          size: 16,
                          color: HexColor("#B7950B"),
                        )),
                  ],
                ),
              ),
              // Row(
              //   children: [
              //     OutlinedButton(
              //         onPressed: () {
              //           FirebaseMessaging.instance
              //               .subscribeToTopic("announcements");
              //         },
              //         child: Text(
              //           "subscribe",
              //           style: TextStyle(color: HexColor("#B7950B")),
              //         )),
              //     const SizedBox(
              //       width: 20,
              //     ),
              //     // OutlinedButton(
              //     //     onPressed: () {
              //     //       FirebaseMessaging.instance
              //     //           .unsubscribeFromTopic("announcements");
              //     //     },
              //     //     child: Text(
              //     //       "un subscribe",
              //     //       style: TextStyle(color: HexColor("#B7950B")),
              //     //     ))
              //   ],
              // )
            ],
          ),
        );
      },
    );
  }
}
