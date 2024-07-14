import 'package:get/get.dart';

import '../../../models/ApiResponse.dart';
import 'AppDiagnosticService.dart';
import 'MockDiagnosticService.dart';

abstract class DiagnosticService {
  /// Configure if Mock is enabled or not
  static const MOCK_ENABLED = false;

  /// Create and get the instance of [ReportService]
  static DiagnosticService get instance {
    if (!Get.isRegistered<DiagnosticService>()) Get.lazyPut<DiagnosticService>(() => MOCK_ENABLED ? MockDiagnosticService() : AppDiagnosticService());

    return Get.find<DiagnosticService>();
  }

  Future<ApiResponse> getDiagnosticData({int? page ,String? state, String? city, String? district, String? pincode});

  Future<ApiResponse> getState();

  Future<ApiResponse> getCity({required stateID});
}
