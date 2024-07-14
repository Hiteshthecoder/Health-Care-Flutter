import 'package:flutter/cupertino.dart';
import 'package:flutter_mvc/app/modules/Community/services/CommunityPostService.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/Toastr.dart';

import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../../../shared/controllers/AppController.dart';

class CreateCommunityController extends AppController {
  static CreateCommunityController get to => Get.find<CreateCommunityController>();

  var _buttonEnabled = false.obs;

  /// Observables
  var _tasks = RxList<Map<String, dynamic>>([]);

  TextEditingController textInput = TextEditingController();

  ///Getter

  List<Map<String, dynamic>> get tasks => _tasks;

  bool get buttonEnabled => _buttonEnabled.value;

  ///Variable
  final CommunityPostService _commentService = CommunityPostService.instance;

  @override
  void onInit() {
    super.onInit();

    textInput.addListener(() {
      if (textInput.text.length > 0)
        _buttonEnabled(true);
      else
        _buttonEnabled(false);
    });
  }

  Future<void> createPost() async {
    Map<String, dynamic> body = {
      "description": textInput.text.trim().toString(),
    };
    ApiResponse response = await _commentService.createPost(body: body);
    log.w(response.toJson());

    if (response.hasValidationErrors()) {
      Toastr.show(message: "${response.validationError}");
      return;
    }

    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      return;
    }

    textInput.clear();
    Toastr.show(message: "${response.message}");
    Get.offNamed('/community');
    setBusy(false);
  }
}

void deleteFile(int index) async {
  Get.back();
}
