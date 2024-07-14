
import 'package:get/get.dart';

import '../../../models/ApiResponse.dart';
import 'AppReportService.dart';
import 'MockReportService.dart';

abstract class ReportService {
  /// Configure if Mock is enabled or not
  static const MOCK_ENABLED = false;

  /// Create and get the instance of [ReportService]
  static ReportService get instance {
    if (!Get.isRegistered<ReportService>()) Get.lazyPut<ReportService>(() => MOCK_ENABLED ? MockReportService() : AppReportService());

    return Get.find<ReportService>();
  }
  Future<ApiResponse> getReportData() ;
  Future<ApiResponse> getCategories();
  Future<ApiResponse> organiseReport({required Map<String, dynamic> body,required int authId});
}
