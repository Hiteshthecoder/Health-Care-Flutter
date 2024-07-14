
import 'package:flutter/material.dart';
import 'package:flutter_countr/Countr.dart';
import 'package:flutter_mvc/app/models/ApiResponse.dart';

import 'package:flutter_mvc/app/modules/MyFamily/controllers/MyFamilyController.dart';
import 'package:flutter_mvc/app/modules/MyFamily/services/MyFamilyService.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/Toastr.dart';

import '../../../helpers/Global.dart';
import '../../../shared/controllers/AppController.dart';
import '../../Menu/controllers/MenuController.dart';

class LinkMemberController extends AppController {
  static LinkMemberController get instance => LinkMemberController();
  final MyFamilyController myFamilyController = Get.put(MyFamilyController());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  CountrController?countrController;

  MyFamilyService _familyService = MyFamilyService.instance;
  TextEditingController phoneInput = TextEditingController();
  TextEditingController otpInput = TextEditingController();
  final MenueController menuController = Get.put(MenueController());

  var _hide =  false.obs;
  var _start = '45'.obs;
  var _timeUp = true.obs;

  bool get hide => _hide.value;

  String get start => _start.value;
  bool get timeUp => _timeUp.value;

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
    linkMember();
    linkMemberOtp();
    countrController = CountrController(endTime: int.parse(_start.value).seconds, initialize: true);

  }

Future<void> linkMember() async{
    // setBusy(true);
  if (!formKey.currentState!.validate()) {
    return;
  }
    Map<String ,dynamic> body =  {
      "phone" :  phoneInput.text.trim().toString()
    };
    ApiResponse response = await _familyService.linkMember(body: body);

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
    Toastr.show(message: "${"Otp send successfully"}");

  // myFamilyController.getMemberData();
  // Get.toNamed('/myfamily');


}
  Future<void> linkMemberOtp() async{
    if (!formKey.currentState!.validate()) {
      return;
    }
    Map<String ,dynamic> body =  {
      "phone" :  phoneInput.text.trim().toString(),
      "otp": otpInput.text,
    };
    ApiResponse response = await _familyService.linkMemberOtp(body: body);

    if (response.hasValidationErrors()) {
      Toastr.show(message: "${response.validationError}");
      return;
    }

    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      return;
    }
    await auth.getUser();
    Toastr.show(message: "${response.message}");
    menuController.getMemberData(immediate: true);
    myFamilyController.getMemberData();
    otpInput.clear();
     Get.toNamed('/myfamily');

  }
}


