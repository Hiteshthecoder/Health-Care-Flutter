
import 'package:get/get.dart';

import '../../../models/ApiResponse.dart';
import 'AppInsightService.dart';
import 'MockInsightService.dart';

abstract class InsightService {
  /// Configure if Mock is enabled or not
  static const MOCK_ENABLED = false;

  /// Create and get the instance of [ReportService]
  static InsightService get instance {
    if (!Get.isRegistered<InsightService>()) Get.lazyPut<InsightService>(() => MOCK_ENABLED ? MockInsightService() : AppInsightService());

    return Get.find<InsightService>();
  }
  Future<ApiResponse> getInsightData() ;

}
