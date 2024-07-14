import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jiffy/jiffy.dart';
import 'package:logger/logger.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/Sizes.dart';
import 'package:ui_x/helpers/TextStyl.dart';

import '../shared/controllers/AuthState.dart';
import '../shared/controllers/UserController.dart';

///======================================
/// Get Instance of [AuthState]
///======================================
AuthState authState = AuthState.instance;
AuthState auth = AuthState.instance;
double getBMICalculation({required String weight, required String height}) {
  if (weight != '' && height != '') {
    double wht = double.parse(weight);
    double hgt = double.parse(height);
    double bmi = (wht / hgt / hgt) * 10000;
    return bmi.truncateToDouble();
  }
  return 0;
}

Color getBMIColor({required String height, required String weight}) {
  final value = getBMICalculation(weight: weight, height: height);
  if (value < 18.5) {
    return Colors.blue;
  } else if (value >= 18.5 && value <= 24.9) {
    return Colors.green;
  } else if (value >= 25 && value <= 29.9) {
    return Colors.yellow;
  } else if (value > 30) {
    return Colors.red;
  } else {
    return Colors.black;
  }
}

String getBMIText({required String height, required String weight}) {
  final value = getBMICalculation(weight: weight, height: height);
  if (value < 18.5) {
    return 'Underweight';
  } else if (value >= 18.5 && value <= 24.9) {
    return 'Normal Weight';
  } else if (value >= 25 && value <= 29.9) {
    return 'Overweight';
  } else if (value > 30) {
    return 'Obese';
  } else {
    return '';
  }
}

// get user subscription data
UserController userController = UserController.instance;

///======================================
/// Get storage Helper
///======================================
GetStorage storage = new GetStorage();

///======================================
/// Get screen size helper
///======================================
Size screen = Get.size;

///======================================
/// Image Helper
///======================================
String image(name) {
  return "assets/images/$name";
}

///======================================
/// Icon Helper
///======================================
String assetIcon(name) {
  return "assets/icons/$name";
}

///======================================
/// Check current route
///======================================
bool routeIs(name) {
  return Get.routing.current == name;
}

///======================================
/// Console Logger
///======================================
var log = Logger(
  printer: PrettyPrinter(),
);

///======================================
/// Generate and get MaterialColor From a Color
///======================================
MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: _tintColor(color, 0.9),
    100: _tintColor(color, 0.8),
    200: _tintColor(color, 0.6),
    300: _tintColor(color, 0.4),
    400: _tintColor(color, 0.2),
    500: color,
    600: _shadeColor(color, 0.1),
    700: _shadeColor(color, 0.2),
    800: _shadeColor(color, 0.3),
    900: _shadeColor(color, 0.4),
  });
}

int _tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color _tintColor(Color color, double factor) => Color.fromRGBO(
    _tintValue(color.red, factor),
    _tintValue(color.green, factor),
    _tintValue(color.blue, factor),
    1);

int _shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color _shadeColor(Color color, double factor) => Color.fromRGBO(
      _shadeValue(color.red, factor),
      _shadeValue(color.green, factor),
      _shadeValue(color.blue, factor),
      1,
    );

///======================================
/// Show confirm dialog
///======================================
void showConfirmDialog({
  String message = "You wont be able to revert back!",
  Function()? onConfirm,
  Function()? onCancel,
  String confirmLabel = "Confirm",
  String cancelLabel = "Cancel",
}) {
  Get.dialog(
    Dialog(
      backgroundColor: kcWhite,
      child: Container(
        padding:
            const EdgeInsets.symmetric(vertical: spacer8, horizontal: spacer)
                .copyWith(bottom: 4),
        decoration: BoxDecoration(
          color: kcWhite,
          borderRadius: BorderRadius.circular(spacer2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "You Sure!",
              style: TextStyl.subtitle?.copyWith(fontSize: 18),
            ),
            const SizedBox(height: spacer1),
            Text(
              "$message",
              style: TextStyl.bodySm?.copyWith(color: kcDarkAlt),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: spacer5),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent),
                    child: Text(
                      "$cancelLabel",
                      style: TextStyl.button?.copyWith(color: kcDarkAlt),
                    ),
                    onPressed: () {
                      Get.back();
                      onCancel!();
                    },
                  ),
                ),
                const SizedBox(width: spacer3),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent),
                    child: Text(
                      "$confirmLabel",
                      style: TextStyl.button?.copyWith(color: kcDarkAlt),
                    ),
                    onPressed: () {
                      Get.back();
                      onConfirm!();
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

extension DateExt on DateTime {
  String formatted(String format) {
    return Jiffy(this).format(format);
  }
}

/// ============================
/// Find Highest Value to Insight
/// ============================
int highestValue(String input) {
  List<String> stringNumbers = input.split(",");
  List<int> numbers =
      stringNumbers.map((string) => double.parse(string).round()).toList();
  int highest =
      numbers.reduce((value, element) => value > element ? value : element);
  log.w("$highest:::::::${highest > -1 && highest < 50}");
  if (highest > -1 && highest < 50) {
    return 50;
  } else {
    return highest;
  }
}
