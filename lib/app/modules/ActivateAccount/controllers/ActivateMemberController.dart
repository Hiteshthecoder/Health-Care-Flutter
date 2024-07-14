import 'package:flutter/material.dart';
import 'package:flutter_countr/Countr.dart';
import 'package:flutter_mvc/app/models/ApiResponse.dart';
import 'package:flutter_mvc/app/modules/Menu/controllers/MenuController.dart';
import 'package:flutter_mvc/app/modules/MyFamily/controllers/MyFamilyController.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/Toastr.dart';

import '../../../helpers/Global.dart';
import '../../../shared/controllers/AppController.dart';
import '../services/ActivateAccountService.dart';

class ActivateMemberController extends AppController {
  static ActivateMemberController get instance => ActivateMemberController();

  ///Controller
  final MyFamilyController myFamilyController = Get.put(MyFamilyController());
  final MenueController menuController = Get.put(MenueController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  CountrController? countrController;

  ActivateAccountService _accountService = ActivateAccountService.instance;
  TextEditingController phoneInput = TextEditingController();
  TextEditingController emailInput = TextEditingController();
  TextEditingController otpInput = TextEditingController();

  var _hide = false.obs;
  var _start = '45'.obs;
  var _timeUp = true.obs;
  var _otpSent = false.obs;

  bool get hide => _hide.value;

  String get start => _start.value;

  bool get timeUp => _timeUp.value;
  bool get otpSent => _otpSent.value;

  void onSelect(bool value) {
    _hide(value);
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

  //
  @override
  void onInit() {
    super.onInit();
    // activateAccount();
    // activateAccountOtp();
    countrController = CountrController(endTime: int.parse(_start.value).seconds, initialize: true);
  }

  Future<void> activateAccount() async {
    // setBusy(true);
    if (!formKey.currentState!.validate()) {
      return;
    }
    Map<String, dynamic> body = {"email": emailInput.text.trim().toString(), "phone": phoneInput.text.trim().toString()};
    ApiResponse response = await _accountService.activateAccount(body: body);

    if (response.hasValidationErrors()) {
      Toastr.show(message: "${response.validationError}");
      return;
    }
log.w(response.data);
    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      return;
    }
    //await auth.getUser();

    onSelect(true);
    _otpSent(true);
    Toastr.show(message: "${"Otp send successfully"}");

    // myFamilyController.getMemberData();
    // Get.toNamed('/myfamily');
  }

  Future<void> activateAccountOtp() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    Map<String, dynamic> body = {
      "email": emailInput.text.trim().toString(),
      "phone": phoneInput.text.trim().toString(),
      "otp": otpInput.text,
    };
    ApiResponse response = await _accountService.activateAccountOtp(body: body);

    if (response.hasValidationErrors()) {
      Toastr.show(message: "${response.validationError}");
      return;
    }
    log.w(response.data);
    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      return;
    }
    await auth.getUser();
    Toastr.show(message: "${response.message}");
    menuController.getMemberData(immediate: true);
    myFamilyController.getMemberData();
    emailInput.clear();
    phoneInput.clear();
    otpInput.clear();
    _otpSent(false);
    Get.offAllNamed('/dashboard');
  }
}
