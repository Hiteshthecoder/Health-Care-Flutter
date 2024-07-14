
import 'package:get/get.dart';

import '../../../models/ApiResponse.dart';
import 'AppChartService.dart';
import 'MockChartService.dart';

abstract class ChartService {
  /// Configure if Mock is enabled or not
  static const MOCK_ENABLED = false;

  /// Create and get the instance of [ReportService]
  static ChartService get instance {
    if (!Get.isRegistered<ChartService>()) Get.lazyPut<ChartService>(() => MOCK_ENABLED ? MockChartService() : AppChartService());

    return Get.find<ChartService>();
  }
  Future<ApiResponse> getChartData() ;

}
