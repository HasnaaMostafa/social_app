import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sociall_app_2/layout/home_screen.dart';
import 'package:sociall_app_2/shared/components/BoardingModel.dart';
import 'package:sociall_app_2/shared/cubits/socialAppCubit.dart';
import 'package:sociall_app_2/shared/network/local/cache_helper.dart';

import '../../models/user_model.dart';
import '../../shared/components/app_button.dart';
import '../../shared/components/app_textformfield.dart';
import '../../shared/components/components.dart';
import '../Register/register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialLoginScreen extends StatefulWidget {
  static UserModel? userModel;

  @override
  State<SocialLoginScreen> createState() => _SocialLoginScreenState();
}

class _SocialLoginScreenState extends State<SocialLoginScreen> {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SocialLoginScreen.userModel = UserModel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLoginCubit, SocialLoginStates>(
      listener: (BuildContext context, Object state) {
        if (state is SocialLoginErrorStates) {
          showToast(message: state.error, state: ToastStates.error);
        }

        if (state is SocialLoginSuccessStates) {
          SocialLoginScreen.userModel = state.userModel;
          CacheHelper.saveData(
                  key: "uId", value: SocialLoginScreen.userModel!.uId)
              .then((value) {
            navigateAndFinish(context, const HomeLayout());

            SocialCubit.get(context).getUserData();
            // SocialCubit.get(context).getUsers();
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          // backgroundColor: Colors.white,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: double.infinity,
                    child: Image(
                      fit: BoxFit.fitHeight,
                      image: AssetImage("assets/images/React.png"),
                      width: 200,
                      height: 250,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Text(
                              "LOGIN",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(color: HexColor("#0E6655")),
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            Text(
                              "Welcome Back !",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: HexColor("#B7950B")),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            appTextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                label: "Email Address",
                                hint: "Email",
                                prefix: Icons.email_outlined,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your email";
                                  }
                                  return null;
                                },
                                borderColor: HexColor("#0E6655"),
                                prefixColor: HexColor("#0E6655"),
                                lColor: HexColor("#0E6655"),
                                hColor: Colors.grey,
                                erorrColor: Colors.red),
                            const SizedBox(
                              height: 10,
                            ),
                            appTextFormField(
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                label: "Password",
                                hint: "password",
                                prefix: Icons.lock_outline,
                                suffix: SocialLoginCubit.get(context).suffix,
                                onSubmit: (String? value) {
                                  // if (formKey.currentState!.validate()){
                                  //   SocialLoginCubit.get(context).userLogin(
                                  //       email: emailController.text,
                                  //       password: passwordController.text);
                                  // }
                                },
                                suffixPressed: () {
                                  SocialLoginCubit.get(context)
                                      .changePasswordVisibility();
                                },
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return "please enter your password";
                                  }
                                  return null;
                                },
                                isPassword:
                                    SocialLoginCubit.get(context).isPassword,
                                borderColor: HexColor("#0E6655"),
                                prefixColor: HexColor("#0E6655"),
                                suffixColor: HexColor("#0E6655"),
                                lColor: HexColor("#0E6655"),
                                hColor: Colors.grey,
                                erorrColor: Colors.red),
                            const SizedBox(
                              height: 35,
                            ),
                            ConditionalBuilder(
                                condition: state is! SocialLoginLoadingStates,
                                builder: (context) => appButton(
                                      text: "login",
                                      function: () {
                                        if (formKey.currentState!.validate()) {
                                          SocialLoginCubit.get(context)
                                              .userLogin(
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text);
                                        }
                                      },
                                      background: HexColor("#0E6655"),
                                      size: double.infinity,
                                      textColor: Colors.white,
                                    ),
                                fallback: (context) => const Center(
                                    child: CircularProgressIndicator())),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account ?",
                                  style: TextStyle(
                                    color: HexColor("#0E6655"),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  const RegisterScreen()));
                                    },
                                    child: Text(
                                      "Register now",
                                      style:
                                          TextStyle(color: HexColor("#B7950B")),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
