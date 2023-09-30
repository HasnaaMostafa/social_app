import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sociall_app_2/modules/Login/cubit/cubit.dart';
import 'package:sociall_app_2/shared/bloc_observer.dart';
import 'package:sociall_app_2/shared/components/constatnts.dart';
import 'package:sociall_app_2/shared/cubits/AppStates.dart';
import 'package:sociall_app_2/shared/cubits/Appcubit.dart';
import 'package:sociall_app_2/shared/cubits/socialAppCubit.dart';
import 'package:sociall_app_2/shared/network/local/cache_helper.dart';
import 'package:sociall_app_2/shared/network/remote/dio_helper.dart';
import 'package:sociall_app_2/shared/style/theme.dart';

import 'firebase_options.dart';
import 'layout/home_screen.dart';
import 'modules/on_boarding/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  WidgetsFlutterBinding.ensureInitialized();

  // FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  //
  // var firebasetoken = await FirebaseMessaging.instance.getToken();
  // print(firebasetoken);

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;
  // bool OnBoarding=CacheHelper.getData(key: "onBoarding");
  uId = CacheHelper.getData(key: "uId");

  if (uId != null) {
    widget = const HomeLayout();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;
  const MyApp({super.key, this.isDark, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
        BlocProvider(
            create: (BuildContext context) => SocialCubit()
              ..getUserData()
              ..getPosts()),
        BlocProvider(create: (context) => SocialLoginCubit()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isnotDark
                ? ThemeMode.light
                : ThemeMode.dark,
            home: startWidget,
          );
        },
      ),
    );
  }
}
