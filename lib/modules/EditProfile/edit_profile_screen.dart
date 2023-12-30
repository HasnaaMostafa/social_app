import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sociall_app_2/shared/components/app_button.dart';
import 'package:sociall_app_2/shared/components/app_textformfield.dart';
import 'package:sociall_app_2/shared/components/constatnts.dart';
import 'package:sociall_app_2/shared/cubits/socialAppCubit.dart';
import 'package:sociall_app_2/shared/style/iconBroken.dart';

import '../../shared/components/components.dart';
import '../../shared/cubits/socialAppStates.dart';
import '../Login/cubit/cubit.dart';
import '../Login/login_screen.dart';

class EditProfile extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  EditProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, Object? state) {
        if (state is SocialGetUserDataSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (BuildContext context, Object? state) {
        var userModel = SocialCubit.get(context).usermodel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;

        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: "Edit Profile", actions: [
            appButton(
                function: () {
                  SocialCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                },
                text: "Update",
                textColor: HexColor("#B7950B")),
            const SizedBox(
              width: 15,
            ),
          ]),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUserUpdateLoadingState)
                    LinearProgressIndicator(
                      color: Colors.grey,
                      backgroundColor: defaultColor,
                    ),
                  if (state is SocialUserUpdateLoadingState)
                    const SizedBox(
                      height: 10,
                    ),
                  SizedBox(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4),
                                        topRight: Radius.circular(4)),
                                    image: DecorationImage(
                                      image: (coverImage == null
                                          ? NetworkImage("${userModel.cover}")
                                          : FileImage(coverImage)
                                              as ImageProvider),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: CircleAvatar(
                                    backgroundColor: defaultColor2,
                                    radius: 20,
                                    child: const Icon(
                                      IconBroken.Camera,
                                      size: 16,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                  backgroundColor: HexColor("#B7950B"),
                                  radius: 55,
                                  backgroundImage: (profileImage == null
                                          ? NetworkImage("${userModel.image}")
                                          : FileImage(profileImage))
                                      as ImageProvider),
                            ),
                            IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon: CircleAvatar(
                                  backgroundColor: defaultColor2,
                                  radius: 20,
                                  child: const Icon(
                                    IconBroken.Camera,
                                    size: 16,
                                  ),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                appButton(
                                  text: "UPLOAD PROFILE",
                                  textColor: Colors.white,
                                  background: defaultColor2,
                                  function: () {
                                    SocialCubit.get(context).uploadProfileImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text);
                                  },
                                ),
                                if (state is SocialUserUpdateLoadingState)
                                  const SizedBox(
                                    height: 5,
                                  ),
                                if (state is SocialUserUpdateLoadingState)
                                  LinearProgressIndicator(
                                    color: Colors.grey,
                                    backgroundColor: defaultColor,
                                  ),
                              ],
                            ),
                          ),
                        const SizedBox(
                          width: 5,
                        ),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                appButton(
                                  text: "UPLOAD COVER",
                                  textColor: Colors.white,
                                  background: defaultColor2,
                                  function: () {
                                    SocialCubit.get(context).uploadCoverImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text);
                                  },
                                ),
                                if (state is SocialUserUpdateLoadingState)
                                  const SizedBox(
                                    height: 5,
                                  ),
                                if (state is SocialUserUpdateLoadingState)
                                  LinearProgressIndicator(
                                    color: Colors.grey,
                                    backgroundColor: defaultColor,
                                  ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    const SizedBox(
                      height: 20,
                    ),
                  appTextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      label: "Name",
                      hint: "Name",
                      prefix: IconBroken.User,
                      prefixColor: HexColor("#B7950B"),
                      hColor: HexColor("#B7950B"),
                      lColor: HexColor("#B7950B"),
                      validate: (String? value) {
                        if (value!.isNotEmpty) {
                          return " name must not be empty";
                        }
                        return null;
                      },
                      borderColor: defaultColor),
                  const SizedBox(
                    height: 20,
                  ),
                  appTextFormField(
                      controller: bioController,
                      keyboardType: TextInputType.text,
                      label: "Bio",
                      hint: "Bio",
                      prefix: IconBroken.Info_Circle,
                      prefixColor: HexColor("#B7950B"),
                      hColor: HexColor("#B7950B"),
                      lColor: HexColor("#B7950B"),
                      validate: (String? value) {
                        if (value!.isNotEmpty) {
                          return " bio must not be empty";
                        }
                        return null;
                      },
                      borderColor: defaultColor),
                  const SizedBox(
                    height: 20,
                  ),
                  appTextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      label: "Phone",
                      hint: "Phone",
                      prefix: IconBroken.Call,
                      prefixColor: HexColor("#B7950B"),
                      hColor: HexColor("#B7950B"),
                      lColor: HexColor("#B7950B"),
                      validate: (String? value) {
                        if (value!.isNotEmpty) {
                          return " phone must not be empty";
                        }
                        return null;
                      },
                      borderColor: defaultColor),
                  const SizedBox(
                    height: 150,
                  ),
                  appButton(
                      text: "logout",
                      function: () {
                        BlocProvider.of<SocialLoginCubit>(context)
                            .logoutUser(context);
                        navigateAndFinish(context, SocialLoginScreen());
                        BlocProvider.of<SocialCubit>(context).currentIndex = 0;
                        uId = "";
                      },
                      background: HexColor("#0E6655"),
                      size: 300,
                      textColor: Colors.white),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
