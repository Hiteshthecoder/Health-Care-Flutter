
import 'package:get/get.dart';

import '../../../models/ApiResponse.dart';
import 'AppHealthTipsIndexService.dart';
import 'MockHealthTipsIndexService.dart';

abstract class HealthTipsIndexService {
  /// Configure if Mock is enabled or not
  static const MOCK_ENABLED = false;

  /// Create and get the instance of [ReportService]
  static HealthTipsIndexService get instance {
    if (!Get.isRegistered<HealthTipsIndexService>()) Get.lazyPut<HealthTipsIndexService>(() => MOCK_ENABLED ? MockHealthTipsIndexService() : AppHealthTipsIndexService());

    return Get.find<HealthTipsIndexService>();
  }
  Future<ApiResponse> getHealthTipsData({int? page}) ;

  Future<ApiResponse> getHealthTipsShow({required int healthTipId}) ;

}
