import 'package:currencypro/view/constant/myConstants.dart';
import 'package:flutter/material.dart';

ThemeData mytheme(BuildContext context) {
  return ThemeData(
    useMaterial3: false,
    appBarTheme: const AppBarTheme(elevation: 0),
    cardTheme: CardTheme(
      shadowColor: MyColors.dropDownSearchfontColor,
      color: MyColors.whiteColor,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.white)),
    ),
    primaryColor:Colors.white,// MyColors.whiteColor,
    
    buttonTheme: ButtonThemeData(
      buttonColor: MyColors.dropDownSearchfontColor, //Color(0xFF6391ff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    scaffoldBackgroundColor: MyColors.whiteColor,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: MyColors.dropDownSearchfontColor,
      labelStyle: Theme.of(context).textTheme.bodyMedium,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.0),
        borderSide: BorderSide(color: MyColors.ButtonColor),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: const BorderSide(color: Colors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: BorderSide(color: MyColors.backGroundTextFieldColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: const BorderSide(color: Colors.red),
      ),
    ),
  );
}
