import 'package:flutter_mvc/app/models/HealthTipsIndexModel.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/Toastr.dart';

import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../../../shared/controllers/AppController.dart';
import '../../../shared/views/errors/ServerErrorPage.dart';
import '../services/HealthTipsIndexService.dart';

class BlogsHealthTipsController extends AppController {
  static BlogsHealthTipsController get to => Get.find<BlogsHealthTipsController>();

  ///Observables
  var _blogsDetail = HealthTipsIndexModel().obs;
  var _tasks = RxList<Map<String, dynamic>>([]);
  var _tabIndex = RxInt(0);

  ///Getter
  HealthTipsIndexModel get blogsDetail => _blogsDetail.value;

  List<Map<String, dynamic>> get tasks => _tasks;

  int get tabIndex => _tabIndex.value;

  ///Variable
  final HealthTipsIndexService _healthTipsIndexService = HealthTipsIndexService.instance;

  void onTabChanged(int index) {
    _tabIndex(index);
  }

  @override
  void onInit() {
    super.onInit();
    getHealthTipsShow();
  }

  Future<void> getHealthTipsShow() async {
    try {
      setBusy(true);

      /// Call api to HealthTips user
      ApiResponse response = await _healthTipsIndexService.getHealthTipsShow(healthTipId: int.parse(Get.parameters["healthTip_id"].toString()));

     // log.w(response.toJson());

      if (response.hasError()) {
        Toastr.show(message: "${response.message}");
        setBusy(false);
        return;
      }
      _blogsDetail(HealthTipsIndexModel.fromJson(response.data));
      setBusy(false);
    } on Exception catch (e) {
      Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    }
  }
}
