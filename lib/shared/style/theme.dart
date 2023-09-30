import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme = ThemeData(
              // primarySwatch: Colors.amber,
              //    inputDecorationTheme: InputDecorationTheme(
              //    // enabledBorder: OutlineInputBorder(
              //    //   borderSide: BorderSide(color: HexColor("212121")),),
              //       focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide( color: HexColor("#B7950B")),),),
              floatingActionButtonTheme:
              FloatingActionButtonThemeData(
                  backgroundColor: HexColor("#B7950B")
              ),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                titleSpacing: 20,
                  iconTheme: IconThemeData(
                    color: HexColor("#B7950B"),

                  ),
                  titleTextStyle:const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ) ,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor("#B7950B"),
                      statusBarIconBrightness: Brightness.light
                  )

              ),
              bottomNavigationBarTheme:
               BottomNavigationBarThemeData(
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
                ) ,
              ),

            );

ThemeData darkTheme = ThemeData(
              scaffoldBackgroundColor: HexColor("212121"),
              // primarySwatch: Colors.amber,
              appBarTheme: AppBarTheme(
                titleSpacing: 20,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor:HexColor("212121") ,
                  statusBarIconBrightness: Brightness.light,
                ),
                backgroundColor: HexColor("212121"),
                elevation: 0,
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,

                ),
                iconTheme: const IconThemeData(
                    color: Colors.white
                ),
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
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                ) ,
              ),
            );

