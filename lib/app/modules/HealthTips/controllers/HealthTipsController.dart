import 'package:flutter_mvc/app/models/HealthTipsIndexModel.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/Toastr.dart';

import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../../../shared/controllers/AppController.dart';
import '../services/HealthTipsIndexService.dart';

class HealthTipsController extends AppController {
  static HealthTipsController get to => Get.find<HealthTipsController>();

  ///Observables
  var _health = <HealthTipsIndexModel>[].obs;
  var _loadingMore = false.obs;
  var _dataEnded = false.obs;
  var _page = 1.obs;

  ///Getter
  List<HealthTipsIndexModel> get health => _health;

  bool get loadingMore => _loadingMore.value;

  ///Variable
  final HealthTipsIndexService _healthTipsIndexService = HealthTipsIndexService.instance;

  @override
  void onInit() {
    super.onInit();
    getHealthTipsData();
    scrollController.addListener(() {
      if (double.parse((scrollController.positions.last.maxScrollExtent - 10).toString()) <= scrollController.positions.last.pixels) {
        if (!_dataEnded.value) getHealthTipsData(next: true);
      }
    });
  }

  Future<void> getHealthTipsData({bool immediate = false, bool next = false}) async {
    if (!immediate && !next) setBusy(true);

    /// Call api to login user
    ApiResponse response;

    if (next) setBusy(false);
    if (next) _loadingMore(true);
    if (next) _page(_page.value + 1);

    response = await _healthTipsIndexService.getHealthTipsData(page: _page.value);

   // log.w(response.toJson());

    if (response.hasError()) {
      Toastr.show(message: "${response.message}");

      return;
    }
    if (response.hasData()) {
      if (next) {
        _health.addAll(List<HealthTipsIndexModel>.from(response.data.map((x) => HealthTipsIndexModel.fromJson(x))));
      } else {
        _health.assignAll(List<HealthTipsIndexModel>.from(response.data.map((x) => HealthTipsIndexModel.fromJson(x))));
      }
    } else {
      if (!next) {
        _health.clear();
      }
      _dataEnded(true);
    }
    _loadingMore(false);
    setBusy(false);
  }
}
