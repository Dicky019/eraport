import 'package:eraport/app/data/color.dart';
import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    backgroundColor: Colors.white,
      appBarTheme: AppBarTheme(backgroundColor: ColorPallet().yelowColor),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: ColorPallet().primariColor)
  );
  static final dark = ThemeData.dark().copyWith(
    backgroundColor: Colors.black,
      appBarTheme: AppBarTheme(backgroundColor: ColorPallet().primariColor),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: ColorPallet().yelowColor)
    // buttonColor: Colors.red,
  );
}
