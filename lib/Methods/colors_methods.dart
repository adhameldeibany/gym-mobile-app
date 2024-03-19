import 'package:flutter/material.dart';

final Color lightyellow = Color(0xffF8BE00);
final Color darkgrey = Color(0xff1C1B1F);
final Color silverdark = Color(0xff404040);
final Color greylight = Color(0xff191919);
final Color zeti = Color(0xff867D2C);

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.white,
  ),
);

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: darkgrey,
  ),
);