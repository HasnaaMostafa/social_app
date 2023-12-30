import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class LightTheme {
  static ThemeData getTheme() {
    bool? isDark;
    isDark = false;
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: HexColor("#B7950B")),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
          titleSpacing: 20,
          iconTheme: IconThemeData(
            color: HexColor("#B7950B"),
          ),
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: HexColor("#B7950B"),
              statusBarIconBrightness: Brightness.light)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: HexColor("#B7950B"),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 30.0,
      ),
      textTheme: const TextTheme(
        bodySmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}
