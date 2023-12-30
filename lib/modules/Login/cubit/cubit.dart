import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sociall_app_2/modules/Login/cubit/states.dart';
import 'package:sociall_app_2/shared/cubits/socialAppCubit.dart';

import '../../../models/user_model.dart';
import '../../../shared/network/local/cache_helper.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialStates());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  FirebaseAuth auth = FirebaseAuth.instance;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingStates());

    auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user?.email);
      print(value.user?.uid);

      String uid = value.user!.uid;
      String email = value.user!.email ?? '';
      String name =
          ''; // Fetch the user's name from another data source, e.g., Firestore

      UserModel user = UserModel(uId: uid, email: email, name: name);

      emit(SocialLoginSuccessStates(user));
    }).catchError((error) {
      emit(SocialLoginErrorStates(error.toString()));
    });
  }

  void logoutUser(context) async {
    emit(LogoutLoadingState());
    await auth.signOut().then((value) {
      SocialCubit.get(context).profileImage = null;
      SocialCubit.get(context).coverImage = null;
      CacheHelper.removeData(key: "uId");
      print("remove");
      emit(LogoutSuccessState());
    }).catchError((error) {
      emit(LogoutErrorState(error: error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(SocialChangePasswordVisibilityStates());
  }
}
