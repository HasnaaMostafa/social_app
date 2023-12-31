import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sociall_app_2/shared/cubits/socialAppCubit.dart';
import 'package:sociall_app_2/shared/cubits/socialAppStates.dart';
import 'package:sociall_app_2/shared/style/iconBroken.dart';

import '../modules/new_posts/new_post_screen.dart';
import '../shared/components/components.dart';
import '../shared/theme/cubit/theme_cubit.dart';
import '../shared/theme/light_theme.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, Object state) {
        if (state is SocialNewPostsState) {
          navigateTo(context, const NewPostsScreen());
        }
      },
      builder: (BuildContext context, Object state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                  onPressed: () {
                    SocialCubit.get(context).getPosts();
                  },
                  icon: const Icon(Icons.refresh)),
              IconButton(
                onPressed: () {
                  BlocProvider.of<ThemeCubit>(context).toggleTheme();
                },
                icon: BlocBuilder<ThemeCubit, ThemeData>(
                  builder: (context, theme) {
                    return theme == LightTheme.getTheme()
                        ? const Icon(Icons.nightlight_round_outlined)
                        : const Icon(Icons.wb_sunny_outlined);
                  },
                ),
              )
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat), label: "Chats"),
              // BottomNavigationBarItem(icon: Icon(Icons.group), label: "Groups"),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload), label: "Post"),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Game), label: "Games"),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.User), label: "Profile"),
            ],
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
          ),
          // body: ConditionalBuilder(
          //   condition: SocialCubit.get(context).model != null,
          //   builder: (BuildContext context)=>Column(
          //     children: [
          //       if(!FirebaseAuth.instance.currentUser!.emailVerified)
          //       Container(
          //         color: Colors.amber.withOpacity(0.6),
          //         child: Padding(
          //           padding: const EdgeInsets.symmetric(
          //               horizontal: 20
          //           ),
          //           child: Row(
          //             children: [
          //               const Icon(
          //                   Icons.info_outline),
          //               const SizedBox(
          //                 width: 15,
          //               ),
          //               const Expanded(
          //                 child: Text(
          //                     "please verify your email"),
          //               ),
          //               const SizedBox(
          //                 width: 20,
          //               ),
          //               TextButton(
          //                 onPressed: () {
          //                   FirebaseAuth.instance.currentUser?.sendEmailVerification()
          //                       .then((value) {
          //                         showToast(message: "check your email", state: ToastStates.success);
          //                   }).catchError((error){
          //
          //                   });
          //                 },
          //                 child: Text("verify",
          //                   style: TextStyle(
          //                       color: HexColor("#0E6655")
          //                   ),),)
          //             ],
          //           ),
          //         ),
          //       )
          //     ],
          //   ) ,
          //   fallback:  (BuildContext context)=>const Center(child: CircularProgressIndicator()),
          // ),
        );
      },
    );
  }
}
