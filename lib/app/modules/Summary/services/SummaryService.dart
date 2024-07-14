
import 'package:get/get.dart';

import '../../../models/ApiResponse.dart';
import 'AppSummaryService.dart';
import 'MockSummaryService.dart';

abstract class SummaryService {
  /// Configure if Mock is enabled or not
  static const MOCK_ENABLED = false;

  /// Create and get the instance of [ReportService]
  static SummaryService get instance {
    if (!Get.isRegistered<SummaryService>()) Get.lazyPut<SummaryService>(() => MOCK_ENABLED ? MockSummaryService() : AppSummaryService());

    return Get.find<SummaryService>();
  }
  Future<ApiResponse> getSummaryData() ;

}
