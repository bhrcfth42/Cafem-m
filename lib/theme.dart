import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFFFC61F);
const ksecondaryColor = Color(0xFFB5BFD0);
const kTextColor = Color(0xFF50505D);
const kTextLightColor = Color(0xFF6A727D);

ThemeData lightThemeData = ThemeData(
  primaryColor: kPrimaryColor,
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
    bodyText1: TextStyle(color: ksecondaryColor),
    bodyText2: TextStyle(color: ksecondaryColor),
  ),
);
