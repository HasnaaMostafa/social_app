import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../network/local/cache_helper.dart';
import 'AppStates.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit() : super(AppInitialStates());

  static AppCubit get(context)=>BlocProvider.of(context);

  bool isnotDark=false;

  void changeAppMode({bool?fromShared}){
    if(fromShared != null){
      isnotDark=fromShared;
      emit(AppChangeModeState());
    }
    else {
      isnotDark = !isnotDark;
      CacheHelper.putBoolData(key: "isDark", value: isnotDark).
      then((value) {
        emit(AppChangeModeState());
      });
    }
  }}