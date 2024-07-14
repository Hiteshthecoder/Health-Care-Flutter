import 'package:flutter/material.dart';

/// Neutral Colors
const Color kcWhite = Color(0xffffffff);
// const Color kcOffWhite = Color(0xfff1f1f1);
const Color kcOffWhite = Color(0xFFC5CAE9);
const Color kcBlack = Color(0xff151515);

/// GRAY Colors
const Color kcGray = Color(0xffcdcdcd);
const Color kcLightGray = Color(0xffeeeeee);

/// All Dark Colors
const Color kcDark = Color(0xFF414141);
const Color kcDarkAlt = Color(0xFF7E7E7E);
const Color kcDarker = Color(0xFF252929);
const Color kcDarkest = Color(0xFF191C1C);
const Color kcLightYellow = Color(0xFFfffdf3);
const Color kcGreen = Color(0xFF39b48e);
const Color kcNBlue = Color(0xFF003366);
const Color kclightBlue = Color(0xFFe5ecf6);
const Color kcDGreen = Color(0xFF188038);
const Color kcLightGreen = Color(0xFFB9DEC4);
const Color kcBlue = Color(0xFF093674);
const Color kcLightPink = Color(0xFFfff1ed);
const Color kcoffLightPink = Color(0xFFfdeff4);
const Color kcLightPurple = Color(0xFFf4f4ff);
const Color kcSkyBlue = Color(0xFFf2fbff);
const Color kcOrange = Color(0xFFfc7940);

/// Theme colors
//const Color kcPrimary = Color(0xffFF5850);
//  const Color kcPrimary = Color(0xff0095b6);
const Color kcPrimary = Colors.indigo;

const Color kcPrimaryLight = Color(0xffff8179);
const Color kcSecondary = Color(0xFF252929);
const Color kcAccent = Color(0xffdddd2e);
const Color kcDanger = Color(0xFFEB3349);
const Color kcSuccess = Color(0xFF46db43);
// const Color kcInfo = Color(0xFF2775C8);
const Color kcInfo = kcPrimary;
const Color kcWarning = Color(0xFFF59E0B);
const Color kcPurple = Color(0xFF7770b4);
const Color kcdblue = Color(0xFF0095b6);
const Color kcDecent = Color(0xFFf4ae35);

const Color kcTopNavHome = Color(0xFFffffff);
const Color kcTopNavChild = Color(0xFF0095b6);
const Color kcofffWhite = Color(0xfff2f2f2);

// const Color kcBottomNavIcon = Color(0xFF0095b6);
// const Color kcBottomNavMainIcon = Color(0xFF0095b6);
// const Color kcBottomNavActiveIcon = Color(0xFF0095b6);
const Color kcBottomNavIcon = kcPrimary;
const Color kcBottomNavMainIcon = kcPrimary;
const Color kcBottomNavActiveIcon = kcPrimary;

/// Design specific colors
const Color kcAppbarBackground = kcPrimary;
const Color kcAppBarSearchBoxColor = Color(0xffD34A44);

Color getContrastColor(Color color) {
  int d = 0;

// Counting the perceptive luminance - human eye favors green color...
  double luminance =
      (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;

  if (luminance > 0.7)
    d = 0; // bright colors - black font
  else
    d = 255; // dark colors - white font

  return Color.fromARGB(color.alpha, d, d, d);
}
