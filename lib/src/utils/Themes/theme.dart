import 'package:flutter/material.dart';
import 'package:smartprayer/src/utils/Themes/checkbox_theme.dart';
import 'package:smartprayer/src/utils/Themes/outlined_button_theme.dart';
import 'package:smartprayer/src/utils/Themes/text_theme.dart';
import 'elevated_button_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins' ,
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: STextTheme.lightTextTheme,
    elevatedButtonTheme: SElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: SOutlinedButtonTheme.darkOutlinedButtonTheme,
    checkboxTheme: SCheckboxTheme.lightCheckboxTheme
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins' ,
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: const Color(0xff000000),
    textTheme: STextTheme.darkTextTheme,
    elevatedButtonTheme: SElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: SOutlinedButtonTheme.darkOutlinedButtonTheme,
      checkboxTheme: SCheckboxTheme.lightCheckboxTheme,


  );
}
