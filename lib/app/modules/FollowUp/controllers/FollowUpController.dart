import 'package:flutter/cupertino.dart';
import 'package:flutter_mvc/app/modules/FollowUp/services/FollowupService.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/Toastr.dart';

import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../../../models/FollowupModel.dart';
import '../../../shared/controllers/AppController.dart';
import '../../../shared/views/errors/ServerErrorPage.dart';

class FollowUpController extends AppController {
  static FollowUpController get to => Get.find();

  /// Observables

  var _followupData = <FollowupModel>[].obs;

  /// Getters


  List<FollowupModel> get followupData => _followupData;

  /// Variables

  final FollowupService _followupService = FollowupService.instance;

  @override
  void onInit() {
    super.onInit();
    setBusy(true);
    getFollowupData();
  }

  Future<void> getFollowupData() async {
    try {
      setBusy(true);
      ApiResponse response = await _followupService.getFollowupData();

      log.w(response.toJson());

      if (response.hasError()) {
        // Toastr.show(message: "${response.message}");
        setBusy(false);
        return;
      }

      _followupData.assignAll(List<FollowupModel>.from(response.data.map((x) => FollowupModel.fromJson(x))));
      setBusy(false);
    } on Exception catch (e) {
      Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    }
  }

}
