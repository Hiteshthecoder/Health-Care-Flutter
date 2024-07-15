import 'package:ui_x/ui_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/helpers/Global.dart';

import '../Config.dart';

//======================================
// Input Border
//======================================
OutlineInputBorder _inputBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: kcDarker.withOpacity(0.3),
      width: 1,
    ),
    borderRadius: BorderRadius.all(Radius.circular(4)),
  );
}

//======================================
// Input Error Border
//======================================
OutlineInputBorder _inputErrorBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: kcDanger.withOpacity(0.3),
      width: 1,
    ),
    borderRadius: BorderRadius.all(Radius.circular(4)),
  );
}

//======================================
// Input Theme
//======================================
InputDecorationTheme _inputTheme() {
  return InputDecorationTheme(
      isDense: true,
      filled: true,
      fillColor: kcWhite,
      labelStyle: TextStyle(
        color: kcDark,
      ),
      hintStyle: TextStyle(
        height: 1,
        fontSize: 14,
        color: kcDark.withOpacity(0.5),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: spacer3, horizontal: spacer4),
      prefixStyle: TextStyle(
        color: kcDark,
      ),
      border: _inputBorder(),
      enabledBorder: _inputBorder(),
      focusedBorder: _inputBorder(),
      errorBorder: _inputErrorBorder());
}

//======================================
// Icon Theme
//======================================
IconThemeData _iconTheme = IconThemeData(
  color: kcDark,
  size: 16.0,
);

//======================================
// Light Text Theme
//======================================
TextTheme _textThemeLight = TextTheme(
  headlineSmall: TextStyle(
    fontSize: 35,
    fontFamily: Config.headingFontFamily,
    fontWeight: FontWeight.w600,
    color: kcDarker,
  ),
  headlineMedium: TextStyle(
    fontSize: 30,
    fontFamily: Config.headingFontFamily,
    fontWeight: FontWeight.w600,
    color: kcDarker,
  ),
  headlineLarge: TextStyle(
    fontSize: 25,
    fontFamily: Config.headingFontFamily,
    fontWeight: FontWeight.w600,
    color: kcDarker,
  ),
  titleSmall: TextStyle(
    fontFamily: Config.headingFontFamily,
    fontWeight: FontWeight.w600,
    color: kcWhite,
  ),
  titleMedium: TextStyle(
    fontFamily: Config.headingFontFamily,
    fontWeight: FontWeight.w600,
    color: kcWhite,
  ),
  titleLarge: TextStyle(
    fontFamily: Config.headingFontFamily,
    fontWeight: FontWeight.w600,
    color: kcWhite,
  ),
  bodySmall: TextStyle(
    fontSize: 16.0,
    fontFamily: Config.bodyFontFamily,
    color: kcDarker,
  ),
  bodyMedium: TextStyle(
    fontSize: 14.0,
    fontFamily: Config.bodyFontFamily,
    color: kcDarker,
  ),
  labelMedium: TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    fontFamily: Config.bodyFontFamily,
    color: kcOffWhite,
  ),
);

//======================================
// Light Theme
//======================================
final ThemeData lightThemeData = ThemeData(
  brightness: Brightness.light,
  iconTheme: _iconTheme,
  textTheme: _textThemeLight,
  scaffoldBackgroundColor: kcWhite,
  // backgroundColor: kcWhite,
  primaryColor: kcPrimary,
  primaryColorLight: kcPrimaryLight,
  primarySwatch: generateMaterialColor(kcPrimary),
  hintColor: kcAccent,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      backgroundColor: kcWhite,
    ),
  ),
  buttonTheme: ButtonThemeData(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
  ),
  appBarTheme: AppBarTheme(
    elevation: 0.0,
    backgroundColor: kcWhite,
    iconTheme: IconThemeData(color: kcBlack),
    toolbarTextStyle: TextTheme(
      headlineLarge: TextStyle(
        color: kcOffWhite,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ).headlineLarge,
    titleTextStyle: TextTheme(
      headlineLarge: TextStyle(
        color: kcBlack,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ).headlineLarge,
  ),
  inputDecorationTheme: _inputTheme(),
);
