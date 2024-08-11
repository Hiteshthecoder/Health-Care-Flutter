import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mvc/app/modules/Aabha/services/abha_services.dart';
import 'package:flutter_mvc/app/shared/controllers/AppController.dart';
import 'package:get/get.dart';
import '../../../models/ApiResponse.dart';

class aabha1Controller extends AppController {
  TextEditingController phoneNumberController = TextEditingController();

  AbhaServices _abhaServices = AbhaServices.instance;

  RxBool abhaHealthLockerCheckValue = true.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxString? userPhoneNumber;

  // TextEditingController? abhaAdharFirstFourDigitController = TextEditingController();
  // TextEditingController? abhaAdharSecondFourDigitController = TextEditingController();
  // TextEditingController? abhaAdharThirdFourDigitController = TextEditingController();

  RxBool abhaLinkMyHealthCheckValue = true.obs;

  void changeAbhaHealthLockerCheckValue() {
    abhaHealthLockerCheckValue.value = !abhaHealthLockerCheckValue.value;
  }

  void changeAbhaLinkMyHealthCheckValue() {
    abhaLinkMyHealthCheckValue.value = !abhaLinkMyHealthCheckValue.value;
  }

  getAbhaAdharOTP() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      

      



    } catch (e) {}
  }

  @override
  void onClose() {
    super.onClose();
    phoneNumberController.dispose();
  }
}
