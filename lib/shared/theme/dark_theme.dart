import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class DarkTheme {
  static ThemeData getTheme() {
    bool? isDark;
    isDark = true;
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      scaffoldBackgroundColor: HexColor("212121"),
      // primarySwatch: Colors.amber,
      appBarTheme: AppBarTheme(
        titleSpacing: 20,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor("212121"),
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: HexColor("212121"),
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: HexColor("#B7950B"),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: HexColor("#B7950B"),
        elevation: 30.0,
        unselectedItemColor: Colors.grey,
        backgroundColor: HexColor("212121"),
      ),
      textTheme: const TextTheme(
        bodySmall: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
      ),
    );
  }
}
