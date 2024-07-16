import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mvc/app/shared/controllers/AppController.dart';
import 'package:get/get.dart';

class aabha1Controller extends AppController {
  TextEditingController phoneNumberController = TextEditingController();

  RxBool abhaHealthLockerCheckValue = true.obs;

  RxString? userPhoneNumber;

  TextEditingController? abhaAdharFirstFourDigitController =
      TextEditingController();
  TextEditingController? abhaAdharSecondFourDigitController =
      TextEditingController();
  TextEditingController? abhaAdharThirdFourDigitController =
      TextEditingController();

  RxBool abhaLinkMyHealthCheckValue = true.obs;

  void changeAbhaHealthLockerCheckValue() {
    abhaHealthLockerCheckValue.value = !abhaHealthLockerCheckValue.value;
  }

  void changeAbhaLinkMyHealthCheckValue() {
    abhaLinkMyHealthCheckValue.value = !abhaLinkMyHealthCheckValue.value;
  }

  @override
  void onClose() {
    super.onClose();
    phoneNumberController.dispose();
    abhaAdharFirstFourDigitController?.dispose();
    abhaAdharSecondFourDigitController?.dispose();
    abhaAdharThirdFourDigitController?.dispose();
  }
}
