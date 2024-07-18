import 'package:flutter_mvc/app/Rewards/views/RewardsPage.dart';
import 'package:flutter_mvc/app/modules/Aabha/views/aabha1.dart';
import 'package:flutter_mvc/app/modules/Aabha/views/abha_address_screen.dart';
import 'package:flutter_mvc/app/modules/Aabha/views/abha_adhar_card.dart';
import 'package:flutter_mvc/app/modules/Aabha/views/abha_created_success.dart';
import 'package:flutter_mvc/app/modules/Aabha/views/abha_otp_verfication_screen.dart';
import 'package:flutter_mvc/app/modules/Aabha/views/abha_phone_screen.dart';
import 'package:flutter_mvc/app/modules/Aabha/views/user_agreement_screen.dart';
import 'package:flutter_mvc/app/modules/ActivateAccount/views/ActivateMemberPage.dart';
import 'package:flutter_mvc/app/modules/Auth/views/OTPVerify.dart';
import 'package:flutter_mvc/app/modules/ChatBot/views/ChatBotPage.dart';

import 'package:flutter_mvc/app/modules/Community/views/CreateCommunity.dart';
import 'package:flutter_mvc/app/modules/Contact/views/ContactPage.dart';
import 'package:flutter_mvc/app/modules/Dashboard/views/DashboardPage.dart';
import 'package:flutter_mvc/app/modules/Diagnostic/views/DiagnosticPage.dart';
import 'package:flutter_mvc/app/modules/Doctor/views/DoctorPage.dart';
import 'package:flutter_mvc/app/modules/Documents/views/PdfGeneratePage.dart';
import 'package:flutter_mvc/app/modules/FollowUp/views/FollowUpPage.dart';
import 'package:flutter_mvc/app/modules/HealthTips/views/HealthTipsPage.dart';
import 'package:flutter_mvc/app/modules/Home/views/HomePage.dart';
import 'package:flutter_mvc/app/modules/Insights/views/InsightViewPage.dart';
import 'package:flutter_mvc/app/modules/Journey/views/MyJourneyPage.dart';
import 'package:flutter_mvc/app/modules/LifestylePlan/views/LifestylePlanQuestionnaire.dart';
import 'package:flutter_mvc/app/modules/Menu/views/MenuPage.dart';
import 'package:flutter_mvc/app/modules/MyFamily/views/AddMember.dart';
import 'package:flutter_mvc/app/modules/MyFamily/views/MyFamilyPage.dart';
import 'package:flutter_mvc/app/modules/Profile/views/DoctorProfilePage.dart';
import 'package:flutter_mvc/app/modules/Share/views/SharePage.dart';
import 'package:flutter_mvc/app/modules/Subscribe/views/SubscribePage.dart';
import 'package:flutter_mvc/app/modules/Summary/views/SummaryPage.dart';
import 'package:get/get.dart';
import '../app/modules/Auth/views/EnquiryPage.dart';
import '../app/modules/Community/views/CommentsCommunity.dart';
import '../app/modules/Community/views/CommunityPage.dart';
import '../app/modules/Community/views/RespectsCommunity.dart';
import '../app/modules/Doctor/views/DoctorProfileDetail.dart';
import '../app/modules/Documents/views/PDFCameraPage.dart';
import '../app/modules/EPrescription/views/EPrescriptionPage.dart';
import '../app/modules/EPrescription/views/EPrescriptionShowPage.dart';
import '../app/modules/HealthTips/views/BlogsHealthTipsPage.dart';
import '../app/modules/LifestylePlan/views/LifestylePlanResults.dart';
import '../app/modules/Modules.dart';
import '../app/modules/MyFamily/views/LinkMemberPage.dart';
import '../app/modules/OnboardingScreen/OnboardingModule.dart';
import '../app/modules/Profile/views/EditProfilePage.dart';
import '../app/modules/Profile/views/ProfilePage.dart';
import '../app/modules/Documents/views/ReportPage.dart';
import '../app/modules/Documents/views/UploadReportPage.dart';
import '../app/modules/Report/views/ChartPage.dart';
import '../app/modules/Stories/views/ListRecentStories.dart';
import '../app/modules/Stories/views/StoriesPage.dart';
import '../app/modules/Subscribe/views/BuyPlanPage.dart';
import '../app/modules/Subscribe/views/ResultPage.dart';

List<GetPage> routes = [
  ///================================
  /// Splash Routes
  /// ===============================
  GetPage(name: '/', page: () => LoginPage()),

  ///================================
  /// Auth Routes
  /// ===============================
  GetPage(name: '/login', page: () => LoginPage()),
  GetPage(name: '/register', page: () => RegisterPage()),
  GetPage(name: '/otpVerify', page: () => OTPVerify()),
  GetPage(name: '/enquiry', page: () => EnquiryPage()),

  ///=======================================================///
  ///================================
  /// Dashboard Page Route
  /// ===============================
  GetPage(name: '/dashboard', page: () => DashboardPage()),

  ///================================
  /// Setting Page Route
  /// ===============================
  GetPage(name: '/settings', page: () => SettingsPage()),

  ///================================
  /// Profile Route
  /// ===============================
  GetPage(name: '/profile', page: () => ProfilePage()),
  GetPage(name: '/editProfile', page: () => EditProfilePage()),
  GetPage(name: '/doctorProfile', page: () => DoctorProfilePage()),

  ///================================
  /// Home Page Route
  /// ===============================
  GetPage(name: '/home', page: () => HomePage()),

  ///================================
  /// Contact Page Route
  /// ===============================
  GetPage(name: '/contact', page: () => ContactPage()),

  ///================================
  /// Onboarding Page Route
  /// ===============================
  GetPage(name: '/onboarding', page: () => OnboardingPage()),

  ///================================
  /// Patient Page Route
  /// ===============================
  GetPage(name: '/stories', page: () => StoriesPage()),

  ///================================
  /// Summary Page Route
  /// ===============================
  GetPage(name: '/mySummary', page: () => SummaryPage()),

  ///================================
  /// Summary Page Route
  /// ===============================
  GetPage(name: '/myJourney', page: () => MyJourneyPage()),

  ///================================
  /// insight Page Route
  /// ===============================
  GetPage(name: '/insight', page: () => InsightViewPage()),

  ///================================
  /// chart Page Route
  /// ===============================
  GetPage(name: '/chart', page: () => ChartPage()),

  ///================================
  /// rewards Page Route
  /// ===============================
  GetPage(name: '/rewards', page: () => RewardsPage()),

  ///================================
  /// FollowUp Page Route
  /// ===============================
  GetPage(name: '/followUp', page: () => FollowUpPage()),

  ///================================
  /// RecentStories Page Route
  /// ===============================
  GetPage(name: '/listStories', page: () => ListRecentStories()),

  ///================================
  /// Menu Page Route
  /// ===============================
  GetPage(name: '/menu', page: () => MenuPage()),

  ///================================
  /// Upload Report Page Route
  /// ===============================
  GetPage(name: '/upload', page: () => UploadReportPage()),
  GetPage(name: '/report', page: () => ReportPage()),

  ///================================
  /// Community Page Route
  /// ===============================
  GetPage(name: '/community', page: () => CommunityPage()),
  GetPage(name: '/createcommunity', page: () => CreateCommunity()),
  GetPage(name: '/respectscommunity', page: () => RespectsCommunity()),
  GetPage(name: '/commentsCommunity', page: () => CommentsCommunity()),

  ///================================
  /// Dashboard Page Route
  /// ===============================
  GetPage(name: '/doctor', page: () => DoctorPage()),
  GetPage(name: '/doctorProfileDetail', page: () => DoctorProfileDetail()),

  ///================================
  /// Diagnostic Page Route
  /// ===============================
  GetPage(name: '/diagnostic', page: () => DiagnosticPage()),

  ///================================
  /// Share Page Route
  /// ===============================
  GetPage(name: '/share', page: () => SharePage()),

  ///================================
  /// Subscribe Page Route
  /// ===============================
  GetPage(name: '/subscribe', page: () => SubscribePage()),
  GetPage(name: '/buyPlan', page: () => BuyPlanPage()),
  GetPage(name: '/success', page: () => ResultPage()),

  ///================================
  /// Health Tips Page Route
  /// ===============================
  GetPage(name: '/healthTips', page: () => HealthTipsPage()),
  GetPage(name: '/blogsHealthTips', page: () => BlogsHealthTipsPage()),

  ///================================
  /// My Family Route
  /// ===============================
  GetPage(name: '/myfamily', page: () => MyFamilyPage()),
  GetPage(name: '/addMember', page: () => AddMemberPage()),
  GetPage(name: '/linkmember', page: () => LinkMemberPage()),

  ///================================
  /// Share Page Route
  /// ===============================
  GetPage(name: '/pdfGenerate', page: () => PdfGeneratePage()),
  GetPage(name: '/pdf-camera', page: () => PDFCameraPage()),

  ///================================
  /// Activate Member Page Route
  /// ===============================
  GetPage(name: '/activateMember', page: () => ActivateMemberPage()),

  ///================================
  /// EPrescription Page
  /// ===============================
  GetPage(name: '/ePrescription', page: () => EPrescriptionPage()),
  GetPage(name: '/ePrescriptionShow', page: () => EPrescriptionShowPage()),

  ///================================
  /// Lifestyle Plan Page
  /// ===============================
  GetPage(
      name: '/lifestylePlanQuestionnaire',
      page: () => LifestylePlanQuestionnaire()),
  GetPage(name: '/lifestylePlan', page: () => LifestylePlanResults()),

  ///================================
  /// ChatBot Page
  /// ===============================
  GetPage(name: '/chatbot', page: () => ChatBotPage()),

  ///================================
  /// Aabha1 Page
  /// ===============================
  GetPage(name: '/aabha1', page: () => aabha1()),

  GetPage(name: '/abha-adhar-card', page: () => AbhaAdharCardPage()),
  GetPage(name: '/abha-phone-number', page: () => AbhaPhoneScreen()),
  GetPage(name: '/abha-otp-verify', page: () => AbhaOtpVerificationScreen()),

  GetPage(name: '/user-info-agreement', page: () => UserAgreementScreen()),

  GetPage(name: '/abha-address', page: () => AbhaAdressScreen()),
  GetPage(name: "/abha-created-success", page: () => AbhaCreatedSuccess())
];
