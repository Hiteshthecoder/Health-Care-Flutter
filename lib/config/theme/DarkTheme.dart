import 'package:ui_x/ui_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/helpers/Global.dart';

import '../Config.dart';

///======================================
/// Dark Input Border
///======================================
OutlineInputBorder _inputBorder([Color? color]) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: color != null ? color : kcOffWhite.withOpacity(0.3),
      width: 1,
    ),
    borderRadius: BorderRadius.all(Radius.circular(4)),
  );
}

///======================================
/// Dark Input Theme
///======================================
InputDecorationTheme _inputTheme() {
  return InputDecorationTheme(
    isDense: true,
    labelStyle: TextStyle(
      color: kcOffWhite,
    ),
    hintStyle: TextStyle(
      height: 1,
      fontSize: 14,
      color: kcOffWhite.withOpacity(0.5),
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: spacer3, horizontal: spacer4),
    border: _inputBorder(),
    enabledBorder: _inputBorder(),
    focusedBorder: _inputBorder(),
    errorBorder: _inputBorder(kcDanger),
  );
}

///======================================
/// Dark Icon Theme
///======================================
IconThemeData _iconTheme = IconThemeData(
  color: kcOffWhite,
  size: 16.0,
);

///======================================
/// Dark Text Theme
///======================================
TextTheme _textThemeDark = TextTheme(
  headlineSmall: TextStyle(
    fontSize: 30,
    fontFamily: Config.headingFontFamily,
    fontWeight: FontWeight.w600,
    color: kcWhite,
  ),
  headlineMedium: TextStyle(
    fontSize: 25,
    fontFamily: Config.headingFontFamily,
    fontWeight: FontWeight.w600,
    color: kcWhite,
  ),
  headlineLarge: TextStyle(
    fontSize: 20,
    fontFamily: Config.headingFontFamily,
    fontWeight: FontWeight.w600,
    color: kcWhite,
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
    color: kcOffWhite,
  ),
  bodyMedium: TextStyle(
    fontSize: 14.0,
    fontFamily: Config.bodyFontFamily,
    color: kcOffWhite,
  ),
  labelMedium: TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    fontFamily: Config.bodyFontFamily,
    color: kcOffWhite,
  ),
);

///======================================
/// Dark Theme
///======================================
final ThemeData darkThemeData = ThemeData(
  brightness: Brightness.dark,
  iconTheme: _iconTheme,
  textTheme: _textThemeDark,
  scaffoldBackgroundColor: kcDarkest,
  // backgroundColor: kcDarker,
  primaryColor: kcPrimary,
  primaryColorLight: kcPrimaryLight,
  hintColor: kcAccent,
  primarySwatch: generateMaterialColor(kcPrimary),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      backgroundColor: kcAccent,
    ),
  ),
  buttonTheme: ButtonThemeData(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
  ),
  appBarTheme: AppBarTheme(
    elevation: 0.0,
    backgroundColor: kcPrimary,
    iconTheme: IconThemeData(color: kcOffWhite),
    toolbarTextStyle: TextTheme(
      headlineLarge: TextStyle(
        color: kcOffWhite,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ).headlineLarge,
    titleTextStyle: TextTheme(
      headlineLarge: TextStyle(
        color: kcOffWhite,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ).headlineLarge,
  ),
  inputDecorationTheme: _inputTheme(),
);
