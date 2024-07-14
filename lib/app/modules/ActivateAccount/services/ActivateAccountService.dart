
import 'package:get/get.dart';

import '../../../models/ApiResponse.dart';
import 'AppActivateAccountService.dart';
import 'MockActivateAccountService.dart';

abstract class ActivateAccountService {
  /// Configure if Mock is enabled or not
  static const MOCK_ENABLED = false;

  /// Create and get the instance of [ReportService]
  static ActivateAccountService get instance {
    if (!Get.isRegistered<ActivateAccountService>()) Get.lazyPut<ActivateAccountService>(() => MOCK_ENABLED ? MockActivateAccountService() : AppActivateAccountService());

    return Get.find<ActivateAccountService>();
  }

  Future<ApiResponse> activateAccount({required Map<String, dynamic> body});

  Future<ApiResponse> activateAccountOtp({required Map<String, dynamic> body});
}