import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sociall_app_2/layout/home_screen.dart';
import 'package:sociall_app_2/modules/Login/login_screen.dart';
import 'package:sociall_app_2/shared/components/components.dart';

import '../../shared/components/app_button.dart';
import '../../shared/components/app_textformfield.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phonedController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (BuildContext context, Object state) {
          if (state is SocialUserCreatedSuccessStates) {
            navigateAndFinish(context, const HomeLayout());
          }
        },
        builder: (BuildContext context, Object state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Register",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: HexColor("#0E6655")),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Register now to find new friends",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: HexColor("#B7950B")),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        appTextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            label: "User name",
                            hint: "User name",
                            prefix: Icons.person,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "Please enter name";
                              }
                              return null;
                            },
                            borderColor: HexColor("#0E6655"),
                            prefixColor: Colors.grey,
                            lColor: HexColor("#0E6655"),
                            hColor: Colors.grey,
                            erorrColor: Colors.red),
                        const SizedBox(
                          height: 10,
                        ),
                        appTextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            label: "Email Address",
                            hint: "Email",
                            prefix: Icons.email_outlined,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "Please enter email";
                              }
                              return null;
                            },
                            borderColor: HexColor("#0E6655"),
                            prefixColor: Colors.grey,
                            lColor: HexColor("#0E6655"),
                            hColor: Colors.grey,
                            erorrColor: Colors.red),
                        const SizedBox(
                          height: 10,
                        ),
                        appTextFormField(
                            controller: phonedController,
                            keyboardType: TextInputType.phone,
                            label: "Phone",
                            hint: "Phone",
                            prefix: Icons.phone,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "Please enter phone number";
                              }
                              return null;
                            },
                            borderColor: HexColor("#0E6655"),
                            prefixColor: Colors.grey,
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
                            suffixColor: HexColor("#0E6655"),
                            suffix: SocialRegisterCubit.get(context).suffix,
                            onSubmit: (String? value) {},
                            suffixPressed: () {
                              SocialRegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "please enter password!";
                              }
                              return null;
                            },
                            isPassword:
                                SocialRegisterCubit.get(context).isPassword,
                            borderColor: HexColor("#0E6655"),
                            prefixColor: Colors.grey,
                            lColor: HexColor("#0E6655"),
                            hColor: Colors.grey,
                            erorrColor: Colors.red),
                        const SizedBox(
                          height: 35,
                        ),
                        ConditionalBuilder(
                            condition: state is! SocialRegisterLoadingStates,
                            builder: (context) => appButton(
                                text: "Register",
                                function: () {
                                  if (formkey.currentState!.validate()) {
                                    SocialRegisterCubit.get(context)
                                        .userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phonedController.text,
                                    );
                                  }
                                },
                                background: HexColor("#0E6655"),
                                size: double.infinity,
                                textColor: Colors.white),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator())),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account?"),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              SocialLoginScreen()));
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(color: HexColor("#B7950B")),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
