import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mvc/app/shared/controllers/AuthState.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:ui_x/helpers/ColorPalette.dart';

import 'app/shared/bindings/Bindings.dart';
import 'app/shared/controllers/FCMController.dart';
import 'app/shared/views/widgets/ThemeBuilder.dart';
import 'config/Config.dart';
import 'config/theme/AppTheme.dart';
import 'routes/app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  tz.initializeTimeZones();

  /// Initialize the storage
  await GetStorage.init();

  /// Initialize the Firebase Cloud Messaging controller
  Get.put(FCMController(), permanent: true);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : kcGray,
          statusBarBrightness: Theme.of(context).brightness,
          systemNavigationBarColor: Colors.white),
    );

    return ThemeBuilder(
      builder: (context, _themeMode) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.fadeIn,
          title: "${Config.appName}",
          theme: ThemeData(
              fontFamily: GoogleFonts.getFont("Roboto").fontFamily,
              datePickerTheme: DatePickerThemeData(
                  surfaceTintColor: Colors.white,
                  backgroundColor: Colors.white),
              dialogTheme: DialogTheme(surfaceTintColor: Colors.white),
              bottomSheetTheme: BottomSheetThemeData(
                  surfaceTintColor: Colors.white,
                  backgroundColor: Colors.white),
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ButtonStyle(
                      surfaceTintColor:
                          MaterialStateProperty.all(Colors.white))),
              cardTheme: CardTheme(surfaceTintColor: Colors.white),
              appBarTheme: AppBarTheme(
                  shadowColor: Colors.grey,
                  elevation: 2,
                  surfaceTintColor: Colors.white,
                  backgroundColor: Colors.white)),
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.light,
          initialBinding: GlobalBindings(),
          initialRoute: AuthState().user != null ? "/dashboard" : "/login",
          getPages: routes,
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
