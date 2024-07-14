import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class Config {
  ///======================================
  /// Is Auth Required In App
  ///======================================
  static bool authRequired = true;

  ///======================================
  /// Debug Mode
  ///======================================
  static bool inDebug = true;

  ///======================================
  /// API base url
  ///======================================
  // static String apiBaseUrl = "https://healthdetails.in/api/v1";
  static String apiBaseUrl = "http://3.25.188.231/health/api/v1";

  ///======================================
  /// APP base url
  ///======================================
  // static String appBaseUrl = "https://healthdetails.in";

  ///======================================
  /// App Name
  ///======================================
  static String appName = "DQCare";

  ///======================================
  /// Get storage Helper
  ///======================================
  GetStorage storage = new GetStorage();

  ///======================================
  /// Home/Dashboard URL [To be used to redirect user after login]
  ///======================================
  static String homeUrl = "/";

  ///======================================
  /// Font Family For The Headings And Titles
  ///======================================
  // static String? headingFontFamily = GoogleFonts.nunito().fontFamily;
  static String? headingFontFamily = GoogleFonts.roboto().fontFamily;

  ///======================================
  /// Font Family For The Body Text
  ///======================================
  // static String? bodyFontFamily = GoogleFonts.nunito().fontFamily;
  static String? bodyFontFamily = GoogleFonts.roboto().fontFamily;

  ///======================================
  /// Design screen width
  ///======================================
  static double screenWidth = 375.0;

  ///======================================
  /// Design screen height
  ///======================================
  static double screenHeight = 812.0;

  ///======================================
  /// Terms and Condition base url
  ///======================================
  static String termsAndConditionUrl = "https://healthdetails.in/page/terms";

  ///======================================
  /// Privacy Policy base url
  ///======================================
  static String privacyPolicyUrl = "https://healthdetails.in/page/privacy";

  static int trialPackageId = 1;

  static String supportPhoneNumber = "+916352967612";
}
