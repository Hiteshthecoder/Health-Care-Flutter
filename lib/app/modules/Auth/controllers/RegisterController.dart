import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../../../shared/controllers/AppController.dart';
import '../services/register/RegisterService.dart';



class RegisterController extends AppController {
  static RegisterController get instance => Get.find();
  final RegisterService _registerService = RegisterService.instance;

  /// Observable
  var _selectedState = 0.obs;

  /// Getters
  int get selectedState => _selectedState.value;

  /// Variables
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameInput = TextEditingController();
  final TextEditingController phoneInput = TextEditingController();
  final TextEditingController messageInput = TextEditingController();


  @override
  void onInit() {
    super.onInit();
  }

  Future<void> submitRegistration() async {
    if (!formKey.currentState!.validate()) return;
    Map<String, dynamic> body = {
      "name": nameInput.text.trim().toString(),
      "number": phoneInput.text.trim().toString(),
      "message": messageInput.text.trim().toString(),
    };

    ApiResponse response = await _registerService.submitRegistration(body: body);

    log.w(response.toJson());

    if (response.hasValidationErrors()) {
      // Toastr.show(message: "${response.validationError}");
      return;
    }

    if (response.hasError()) {
      // Toastr.show(message: "${response.message}");
      return;
    }
    await auth.getUser();
    nameInput.clear();
    phoneInput.clear();
    messageInput.clear();
    Get.back();
  }
}
