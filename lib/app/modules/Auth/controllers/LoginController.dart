import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countr/Countr.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../../../shared/controllers/AppController.dart';
import '../../../shared/controllers/FCMController.dart';
import '../../../shared/views/errors/ServerErrorPage.dart';
import '../../Modules.dart';

class LoginController extends AppController {
  static LoginController get instance => Get.find();
  var imageCurrentIndex = 0.obs;
  CountrController? countrController;
  CarouselController carouselController = CarouselController();
  PageController pageController = PageController();
  final LoginService _loginService = LoginService.instance;

  final FCMController fcmController = FCMController.instance;

  List<String> titles = [
    "Organize health reports",
    "Connect with doctors",
    "Share your records",
    "Create your ABHA ID"
  ];

  List<String> subTitles = [
    "Take control of your health data with seamless organization, right at your fingertips.",
    "Access expertise instantly; connect with trusted doctors for personalized care, anytime, anywhere!",
    "Effortlessly share your medical history using QR codes, ensuring secure and instant access for healthcare professionals",
    "Create your unique ABHA ID for seamless access to personalised healthcare services"
  ];

  var _otp = "".obs;
  var _phone = "".obs;
  var _start = '20'.obs;
  var _timeUp = true.obs;
  var loading = false.obs;

  var _number = '0000000000'.obs;

  /// Getters
  String get otp => _otp.value;

  String get phone => _phone.value;

  String get start => _start.value;

  bool get timeUp => _timeUp.value;

  String get number => _number.value;

  /// Variables
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController otpInput = TextEditingController();

  @override
  onInit() async {
    super.onInit();
    countrController = CountrController(
        endTime: int.parse(_start.value).seconds, initialize: true);
    if (await storage.read('phone') != null) {
      phoneNumber.text = await storage.read(
        'phone',
      );
    }
  }

  String getCurrentTitleAccToSlider(int index) {
    return titles[index];
  }

  String getCurrentSubTitleAccToSlider(int index) {
    return subTitles[index];
  }

  void resentTime() {
    countrController!.startTimer();
  }

  void setTimeUp() {
    _timeUp.value = false;
  }

  void setStartTimeUp() {
    _timeUp.value = true;
  }

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      await storage.write('phone', phoneNumber.text);

      /// Prepare form data to be sent to server
      Map<String, dynamic> body = {"phone": phoneNumber.text.trim().toString()};

      /// Call api to login user
      ApiResponse response = await _loginService.submit(body: body);

      log.w(response.toJson());

      if (response.hasValidationErrors()) {
        Toastr.show(message: "${response.validationError}");
        return;
      }

      if (response.hasError()) {
        Toastr.show(message: "${response.message}");
        return;
      }

      /// TODO: Remove this when sending OTP to user's phone
      if (_number.value == phoneNumber.text) _otp(response.data.toString());

      Get.toNamed('/otpVerify');
    } on Exception catch (e) {
      Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    }
  }

  Future<void> submitOtp() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      /// Prepare form data to be sent to server
      Map<String, dynamic> body = {
        "phone": phoneNumber.text,
        "otp": otpInput.text,
      };

      /// Call api to login user
      ApiResponse response = await _loginService.verifyOtp(body: body);

      if (response.hasValidationErrors()) {
        Toastr.show(message: "${response.validationError}");
        return;
      }
      if (response.hasError()) {
        Toastr.show(message: "${response.message}");
        return;
      }

      await auth.setUserData(response.data['user']);
      await auth.setUserToken(response.data['token']);
      await updateUserDeviceToken();
      storage.remove('old_user');
      storage.remove('old_user_is_chief');

      if (int.parse(auth.user.progress!) < 1) {
        Get.offAllNamed('/profile');
        log.w(response.data);
      } else if (int.parse(auth.user.progress!) < 3) {
        if (storage.read('onboarded') != null) {
          Get.offAllNamed('/dashboard');
        } else {
          Get.offAllNamed('/onboarding');
        }
      } else {
        Get.offAllNamed('/dashboard');
      }
    } on Exception catch (e) {
      Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    }
  }

  Future<void> updateUserDeviceToken() async {
    await _loginService
        .updateUserDeviceToken(body: {"fcm_token": fcmController.deviceToken});
  }
}
