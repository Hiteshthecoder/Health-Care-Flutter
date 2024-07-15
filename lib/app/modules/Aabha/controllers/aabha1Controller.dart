import 'package:flutter/widgets.dart';
import 'package:flutter_mvc/app/shared/controllers/AppController.dart';
import 'package:get/get.dart';

class aabha1Controller extends AppController {
  TextEditingController aadhaarCardController = TextEditingController();

  RxBool abhaHealthLockerCheckValue = true.obs;

  RxBool abhaLinkMyHealthCheckValue = true.obs;

  void changeAbhaHealthLockerCheckValue() {
    abhaHealthLockerCheckValue.value = !abhaHealthLockerCheckValue.value;
  }

  void changeAbhaLinkMyHealthCheckValue() {
    abhaLinkMyHealthCheckValue.value = !abhaLinkMyHealthCheckValue.value;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    aadhaarCardController.dispose();
  }
}
