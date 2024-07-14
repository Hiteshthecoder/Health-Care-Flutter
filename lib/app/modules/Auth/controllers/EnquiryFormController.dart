import 'package:flutter/cupertino.dart';
import 'package:flutter_mvc/app/modules/Auth/services/enquiry/EnquiryService.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../../../shared/controllers/AppController.dart';

class EnquiryFormController extends AppController {
  static EnquiryFormController get instance {
    if (!Get.isRegistered<EnquiryFormController>()) Get.put(EnquiryFormController());

    return Get.find<EnquiryFormController>();
  }

  /// Observables



  /// Getters




  /// Variables
  TextEditingController taskInput = TextEditingController();

  final TextEditingController nameInput = TextEditingController();
  final TextEditingController phoneInput = TextEditingController();
  final TextEditingController messageInput = TextEditingController();
  final EnquiryService _enquiryService = EnquiryService.instance;



  final GlobalKey<FormState> formKey = GlobalKey<FormState>();



  Future<void> enquiryForm() async {
    Map<String, dynamic> body = {
      "name": nameInput.text,
      "number": phoneInput.text,
      "message": messageInput.text,
    };


    ApiResponse response = await _enquiryService.enquiryForm(body: body);

log.w(response.toJson());
    if (response.hasValidationErrors()) {
      //  Toastr.show(message: "${response.validationError}");
      return;
    }

    if (response.hasError()) {
      //Toastr.show(message: "${response.message}");
      return;
    }
    await auth.getUser();
    nameInput.clear();
    phoneInput.clear();
    messageInput.clear();
    Get.offNamed("/login");
    Toastr.show(message: "${response.message}");
  }
}
