import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'Comfortaa',
  primaryColor: Colors.deepOrange,
  primaryColorLight: Colors.green,
  brightness: Brightness.light,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.grey,
    selectedItemColor: Colors.lightBlue,
    unselectedItemColor: Colors.white,
    elevation: 2,
    type: BottomNavigationBarType.fixed,
  ),
  textTheme: TextTheme(
    titleMedium: TextStyle(color: Colors.black),
    titleSmall: TextStyle(color: Colors.white),
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.deepPurple),
  appBarTheme: AppBarTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20), // حواف دائرية من الأسفل
      ),
    ),
    elevation: 15,
    titleTextStyle: TextStyle(color: Colors.black),
    backgroundColor: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
);
ThemeData darkTheme = ThemeData(
  fontFamily: 'Comfortaa',
  textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(color: Colors.white),
    backgroundColor: Colors.black,
  ),
  brightness: Brightness.dark,
);
