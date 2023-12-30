import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sociall_app_2/modules/Login/cubit/cubit.dart';
import 'package:sociall_app_2/shared/bloc_observer.dart';
import 'package:sociall_app_2/shared/components/constatnts.dart';
import 'package:sociall_app_2/shared/cubits/socialAppCubit.dart';
import 'package:sociall_app_2/shared/network/local/cache_helper.dart';
import 'package:sociall_app_2/shared/network/remote/dio_helper.dart';
import 'package:sociall_app_2/shared/theme/cubit/theme_cubit.dart';

import 'firebase_options.dart';
import 'layout/home_screen.dart';
import 'modules/on_boarding/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;
  // bool OnBoarding=CacheHelper.getData(key: "onBoarding");

  if (uId != null) {
    widget = const HomeLayout();
  } else {
    widget = const OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
    sharedPreferences: sharedPreferences,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences? sharedPreferences;
  final bool? isDark;
  final Widget? startWidget;
  const MyApp(
      {super.key, this.isDark, this.startWidget, this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => SocialCubit()
              ..getUsers()
              ..getUserData()
              ..getPosts()),
        BlocProvider(create: (context) => SocialLoginCubit()),
        BlocProvider(
          create: (context) => ThemeCubit(sharedPreferences!),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme,
            home: const OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
