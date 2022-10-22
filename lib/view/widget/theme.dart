import 'package:currencypro/view/constant/myConstants.dart';
import 'package:flutter/material.dart';

ThemeData mytheme(BuildContext context) {
  return ThemeData(
    appBarTheme: const AppBarTheme(elevation: 2),
    cardTheme: CardTheme(
      shadowColor: MyColors.shadowColor,
      color: MyColors.greyColor,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.white)),
    ),
    primaryColor: MyColors.primaryColor,
    buttonTheme: ButtonThemeData(
      buttonColor: const Color(0xFF6391ff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    scaffoldBackgroundColor: const Color(0xfffafbff),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: const Color(0xFFE5E5E5),
      labelStyle: Theme.of(context).textTheme.subtitle1,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.0),
        borderSide: const BorderSide(color: Colors.red),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: const BorderSide(color: Colors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: const BorderSide(color: Colors.red),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: const BorderSide(color: Colors.red),
      ),
    ),
  );
}
